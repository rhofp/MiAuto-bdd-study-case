--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      auto_carga en N1 (insert, delete)

create or replace trigger t_dml_auto_carga
  instead of insert or update or delete on auto_carga
declare
  v_count number;
begin 
  case
  when inserting then

    -- verifica si hay correspondencia local para evitar acceso remoto
    select count(*) into v_count
    from auto_f1
    where auto_id = :new.auto_id
    and upper(tipo) = 'C';

    -- insercion local
    if v_count > 0 then
      insert into auto_carga_f1 (auto_id, peso_maximo, volumen, 
        tipo_combustible)
      values (:new.auto_id, :new.peso_maximo, :new.volumen,
        :new.tipo_combustible);

    else 
      select count(*) into v_count
      from auto_f2
      where auto_id = :new.auto_id
      and tipo = 'C';

      -- insercion remota
      if v_count > 0 then
        insert into auto_carga_f2 (auto_id, peso_maximo, volumen, 
          tipo_combustible)
        values (:new.auto_id, :new.peso_maximo, :new.volumen,
          :new.tipo_combustible);
      
      else
        raise_application_error(-20020, 
          'Error de integridad para el campo auto_id: '
          ||  :new.auto_id
          || ' No se encontro el registro padre en fragmentos');
      end if;
    end if;
  
  when deleting then
    select count(*) into v_count
    from auto_carga_f1
    where auto_id = :old.auto_id;

    if v_count > 0 then
      delete from auto_carga_f1 where auto_id = :old.auto_id;
    else
      delete from auto_carga_f2 where auto_id = :old.auto_id;
    end if;

  when updating then
    raise_application_error(-20030, 
      'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/


