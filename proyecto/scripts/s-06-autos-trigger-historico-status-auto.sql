--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para la vista
--                      historico_status_auto  (insert, delete)

create or replace trigger t_dml_historico_status_auto
  instead of insert or update or delete on historico_status_auto
declare
  v_count number;
begin 
  case
  when inserting then
    select count(*) into v_count
    from auto_f3
    where auto_id = :new.auto_id;

    if v_count > 0 then
      if to_char(:new.fecha_status, 'yyyy') > '2010' then
        insert into historico_status_auto_f1 (historico_status_id, fecha_status,
          auto_id, status_auto_id)
        values (:new.historico_status_id, :new.fecha_status, 
          :new.auto_id, :new.status_auto_id);
      
      elsif to_char(:new.fecha_status, 'yyyy') <= '2010' then
        insert into historico_status_auto_f2 (historico_status_id, fecha_status,
          auto_id, status_auto_id)
        values (:new.historico_status_id, :new.fecha_status, 
          :new.auto_id, :new.status_auto_id);
      
      else
        raise_application_error(-20010, 
          'Error, el valor ' || :new.fecha_status || ' no es valido');
      end if;
    
    else 
      raise_application_error(-20020, 
        'Error de integridad para el campo auto_id: '
        ||  :new.auto_id
        || ' No se encontro el registro padre en fragmentos');
    end if;
  
  when deleting then
    if to_char(:old.fecha_status, 'yyyy') > '2010' then
      delete from historico_status_auto_f1
      where historico_status_id = :old.historico_status_id;
    
    elsif to_char(:old.fecha_status, 'yyyy') <= '2010' then
      delete from historico_status_auto_f2
      where historico_status_id = :old.historico_status_id;

    else
      raise_application_error(-20010, 
        'Error, el valor de fecha_status no es valido');
    
    end if;
  
  when updating then 
    raise_application_error(-20030, 
      'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/

