--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      tarjeta_cliente (insert, delete)

create or replace trigger t_dml_tarjeta_cliente
  instead of insert or update or delete on hist_status_auto
declare
  v_count number;
begin 
  case
  when inserting then
    select count(*) into v_count
    from cliente
    where cliente_id = :new.cliente_id;

    if v_count > 0 then
      insert into tarjeta_cliente_f1 (cliente_id, anio_expira,
        mes_expira, tipo)
      values (:new.cliente_id, :new.anio_expira, 
        :new.mes_expira, :new.tipo);

      insert into tarjeta_cliente_f2 (cliente_id, num_tarjeta, 
        codigo_seguridad)
      values (:new.cliente_id, :new.num_tarjeta, :new.codigo_seguridad);

    else
      raise_application_error(-20020, 
        'Error de integridad para el campo cliente_id: '
        ||  :new.cliente_id
        || ' No se encontro el registro padre en fragmentos');
    
    end if;

  when deleting then
    delete from tarjeta_cliente_f1 where cliente_id = :old.cliente_id;
    delete from tarjeta_cliente_f2 where cliente_id = :old.cliente_id;

  when updating then
    raise_application_error(-20030, 
        'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/
