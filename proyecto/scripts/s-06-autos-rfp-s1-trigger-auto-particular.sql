--@Author:              Rodrigo Francisco Pablo
--@Fecha de creacion:   22/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      auto_particular en rfp-s1 (insert, delete)

create or replace trigger t_dml_auto_particular
  instead of insert or update or delete on auto_particular
declare
  v_count number;
begin 
  case
  when inserting then

    -- verifica si hay correspondencia local para evitar acceso remoto
    select count(*) into v_count
    from auto_f1
    where auto_id = :new.auto_id
    and upper(tipo) = 'P';

    -- insercion local
    if v_count > 0 then
      insert into auto_particular_f1 (auto_id, num_cilindros, num_pasajeros,
      clase)
      values (:new.auto_id, :new.num_cilindros, :new.num_pasajeros, :new.clase);

    else 
      select count(*) into v_count
      from auto_f2
      where auto_id = :new.auto_id
      and tipo = 'P';

      -- insercion remota
      if v_count > 0 then
        insert into auto_particular_f2 (auto_id, num_cilindros, num_pasajeros,
        clase)
        values (:new.auto_id, :new.num_cilindros, :new.num_pasajeros, 
        :new.clase);
      
      else
        raise_application_error(-20020, 
          'Error de integridad para el campo auto_id: '
          ||  :new.auto_id
          || ' No se encontro el registro padre en fragmentos');
      end if;
    end if;
  
  when deleting then
    select count(*) into v_count
    from auto_particular_f1
    where auto_id = :old.auto_id;

    if v_count > 0 then
      delete from auto_particular_f1 where auto_id = :old.auto_id;
    else
      delete from auto_particular_f2 where auto_id = :old.auto_id;
    end if;

  when updating then
    raise_application_error(-20030, 
      'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/


