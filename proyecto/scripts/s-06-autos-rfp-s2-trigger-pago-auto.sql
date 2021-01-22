--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      pago_auto en N2 (insert, delete)

create or replace trigger t_dml_pago_auto
  instead of insert or update or delete on pago_auto
declare
  v_count number;
begin 
  case
  when inserting then

    -- verificar correspondencia con cliente_id
    select count(*) into v_count
    from cliente
    where cliente_id = :new.cliente_id;

    if v_count > 0 then 
      -- verifica si hay correspondencia local para evitar acceso remoto
      select count(*) into v_count
      from auto_f2
      where auto_id = :new.auto_id;

      if v_count > 0 then
        insert into ti_pago_auto_f2 (cliente_id, auto_id, fecha_pago,
          importe, recibo_pago) 
        values (:new.cliente_id, :new.auto_id, :new.fecha_pago, 
          :new.importe, :new.recibo_pago);

        insert into pago_auto_f2
          select * from ti_pago_auto_f2
          where cliente_id = :new.cliente_id
          and auto_id = :new.auto_id;

        delete from ti_pago_auto_f2
        where cliente_id = :new.cliente_id
        and auto_id = :new.auto_id;
      
      else
        select count(*) into v_count
        from auto_f1
        where auto_id = :new.auto_id;

        if v_count > 0 then
          -- insercion remota, se hce uso de la tabla temporal por BLOB
          insert into ti_pago_auto_f1 (cliente_id, auto_id, fecha_pago,
            importe, recibo_pago) 
          values (:new.cliente_id, :new.auto_id, :new.fecha_pago, 
            :new.importe, :new.recibo_pago);

          insert into pago_auto_f1
            select * from ti_pago_auto_f1
            where cliente_id = :new.cliente_id
            and auto_id = :new.auto_id;

          delete from ti_pago_auto_f1
          where cliente_id = :new.cliente_id
          and auto_id = :new.auto_id;

        else
          raise_application_error(-20020, 
            'Error de integridad para el campo auto_id: '
            || :new.auto_id
            || ' No se encontro el registro padre en fragmentos');
        end if;
      end if;
    else
      raise_application_error(-20020, 
        'Error de integridad para el campo cliente_id: '
        || :new.cliente_id
        || ' No se encontro el registro padre en fragmentos');
    end if;
  
  when deleting then
    select count(*) into v_count
    from auto_f2
    where auto_id = :old.auto_id;

    if v_count > 0 then
      delete from pago_auto_f2
      where auto_id = :old.auto_id
      and cliente_id = :old.cliente_id; 
    else
      delete from pago_auto_f1
      where auto_id = :old.auto_id
      and cliente_id = :old.cliente_id; 
    end if;
  
  when updating then 
    raise_application_error(-20030, 
      'Error, sentencia UPDATE no soportada');
    
  end case;
end;
/