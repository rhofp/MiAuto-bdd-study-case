--@Author:              Rodrigo Francisco Pablo
--@Fecha de creacion:   22/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      auto en rfp-s2 (insert, delete)

create or replace trigger t_dml_auto
  instead of insert or update or delete on auto
declare
  v_count number;
begin 
  case
  when inserting then
    select count(*) into v_count 
    from sucursal_f2
    where sucursal_id = :new.sucursal_id;

    if v_count > 0 then 
      -- Se realiza insercion local
      insert into auto_f2( auto_id, anio, num_serie, tipo, precio,
        fecha_status, sucursal_id, status_auto_id, modelo_id)
      values( :new.auto_id, :new.anio, :new.num_serie, :new.tipo, :new.precio,
        :new.fecha_status, :new.sucursal_id, :new.status_auto_id,
        :new.modelo_id);
    else 
      select count(*) into v_count 
      from sucursal_f1
      where sucursal_id = :new.sucursal_id;

      if v_count > 0 then 
        -- Se inserta en auto_f1 (remoto)
      insert into auto_f1( auto_id, anio, num_serie, tipo, precio,
        fecha_status, sucursal_id, status_auto_id, modelo_id)
      values( :new.auto_id, :new.anio, :new.num_serie, :new.tipo, :new.precio,
        :new.fecha_status, :new.sucursal_id, :new.status_auto_id,
        :new.modelo_id);
      else 
        -- No cumple con el criterio de frag derivada
        raise_application_error(-20020, 
          'Error de integridad para el campo sucursal_id: '
          ||  :new.sucursal_id
          || ' No se encontro el registro padre en fragmentos');
      end if;
    end if;

    -- Siempre se hace la insercion en auto_f3 (remoto)
    -- Se inserta en la tabla temporal para poder insertar dato BLOB (foto) 
    insert into ti_auto_f3(auto_id,foto)
      values(:new.auto_id,:new.foto);

    insert into auto_f3(auto_id,foto)
      select * from ti_auto_f3
      where auto_id = :new.auto_id;

    -- Limpieza de la tabla temporal
    delete from ti_auto_f3;

  when deleting then
    select count(*) into v_count 
    from sucursal_f2
    where sucursal_id = :old.sucursal_id;

    if v_count > 0 then 
      -- Se realiza eliminacion local
      delete from auto_f2 where auto_id = :old.auto_id;
    else 
      select count(*) into v_count 
      from sucursal_f1
      where sucursal_id = :old.sucursal_id;

      if v_count > 0 then 
        -- Se inserta en auto_f1 (remoto)
        delete from auto_f1 where auto_id = :old.auto_id;
      else 
        -- No cumple con el criterio de frag derivada
        raise_application_error(-20020, 
          'Error de integridad para el campo sucursal_id: '
          ||  :old.sucursal_id
          || ' No se encontro el registro padre en fragmentos');
      end if;
    end if;
    -- Siempre se hace la eliminacion en auto_f3
    delete from auto_f3 where auto_id = :old.auto_id;

  when updating then 
    raise_application_error(-20030, 
      'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/
show errors
