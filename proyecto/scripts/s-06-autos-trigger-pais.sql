--@Author:              Rodrigo Francisco Pablo
--@Fecha de creacion:   20/01/2021
--@Descripcion:         Instead of trigger empleado para implementar
--                      replicacion en la tabla pais (insert, delete)

create or replace trigger t_dml_pais
  instead of insert or update or delete on pais
declare
  v_count number;
begin
  case
  when inserting then
    if upper(:new.clave) = 'AME' then 
      -- Se inserta en pais_f1
      insert into pais_f1( pais_id, nombre, clave, region) 
      values ( :new.pais_id, :new.nombre, :new.clave, :new.region);
    elsif upper(:new.clave) = 'EUR' then 
      -- Se inserta en pais_f2
      insert into pais_f2( pais_id, nombre, clave, region) 
      values ( :new.pais_id, :new.nombre, :new.clave, :new.region);
    else 
      -- No se cumple con las reglas del esquema de fragmentacion
      raise_application_error(-20010,
      'La clave ingresada es invalida: ' || :new.clave
      || 'Solo se permiten las claves AME y EUR');
    end if;

  when updating then
    raise_application_error(-20030, 
      'La instruccion update no se encuentra implementada');

  when deleting then 
    if upper(:new.clave) = 'AME' then 
      -- Se elimina en pais_f1
      delete from pais_f1 where pais_id = :old.pais_id;
    elsif upper(:new.clave) = 'EUR' then 
      -- Se elimina en pais_f2
      delete from pais_f2 where pais_id = :old.pais_id;
    else 
      raise_application_error(-20010,
      'Incosistencia, valor incorrecto para la clave'
      || 'Solo se permiten las claves AME y EUR');
    end if;

  end case;
end;
/
