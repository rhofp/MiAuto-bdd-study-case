--@Author:              Rodrigo Francisco Pablo
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para implementar
--                      DML en la sucursal para rfp-s1 (insert, delete)
create or replace trigger t_dml_sucursal
  instead of insert or update or delete on sucursal
declare
  v_count number;
begin
  case
  when inserting then
    if :new.clave != '00000' then
      -- Verifica si hay correspondencia local para evitar acceso remoto
      select count(*) into v_count 
      from pais_f2
      where pais_id = :new.pais_id;
      
      if v_count > 0 then 
        -- Insertar en sucursal_f2 (local)
        insert into sucursal_f2( sucursal_id, nombre, clave, 
          sucursal_anexa_id, pais_id)
        values( :new.sucursal_id, :new.nombre, :new.clave, 
          :new.sucursal_anexa_id, :new.pais_id);
      else 
        -- Verificar correspondencia en fragmento remoto
        select count(*) into v_count 
        from pais_f1
        where pais_id = :new.pais_id;
    
        if v_count > 0 then 
          -- Insertar en sucursal_f1 (remoto)
          insert into sucursal_f1( sucursal_id, nombre, clave, 
            sucursal_anexa_id, pais_id)
          values( :new.sucursal_id, :new.nombre, :new.clave, 
            :new.sucursal_anexa_id, :new.pais_id);
        else 
          -- Error, no se cumple el criterio de frag derivada
          raise_application_error(-20020,
          'Error de integridad para el campo pais_id: ' || :new.pais_id
          || 'No se encontro el registro padre en los fragmentos');
        end if;
      end if;

    elsif :new.clave = '00000' then
      -- Insertar en sucursal_f3
      insert into sucursal_f3( sucursal_id, nombre, clave, 
        sucursal_anexa_id, pais_id)
      values( :new.sucursal_id, :new.nombre, :new.clave, 
        :new.sucursal_anexa_id, :new.pais_id);
    else 
      -- Error en la clave 
      raise_application_error(-20010,
      'Error de fragmentacion primaria, la clave ' || :new.clave 
      || 'es incorrecta');
    end if;

  when updating then
    raise_application_error(-20030, 
      'La instruccion update no se encuentra implementada');

  when deleting then 
    if :old.clave != '00000' then
      -- Verifica si hay correspondencia local para evitar acceso remoto
      select count(*) into v_count 
      from pais_f1
      where pais_id = :old.pais_id;
      
      if v_count > 0 then 
        -- eliminar en sucursal_f1 (local)
        delete from sucursal_f1 where sucursal_id = :old.sucursal_id;
      else 
        -- Verificar correspondencia en fragmento remoto
        select count(*) into v_count 
        from pais_f2
        where pais_id = :old.pais_id;
    
        if v_count > 0 then 
          -- eliminar en sucursal_f2 (remoto)
          delete from sucursal_f2 where sucursal_id = :old.sucursal_id;
        else 
          -- Error, no se cumple el criterio de frag derivada
          raise_application_error(-20020,
          'Error de integridad para el campo pais_id: ' || :old.pais_id
          || 'No se encontro el registro padre en los fragmentos');
        end if;
      end if;

    elsif :old.clave = '00000' then
      -- eliminar en sucursal_f3
        delete from sucursal_f3 where sucursal_id = :old.sucursal_id;
    else 
      -- Error en la clave 
      raise_application_error(-20010,
      'Error de fragmentacion primaria, la clave ' || :old.clave 
      || 'es incorrecta');
    end if;

  end case;
end;
/
