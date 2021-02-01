--@Author:              Rodrigo Francisco Pablo
--@Fecha de creacion:   21/01/2021
--@Descripcion:         Instead of trigger empleado para implementar
--                      DML en la cliente (insert, delete)

create or replace trigger t_dml_cliente
  instead of insert or update or delete on cliente
declare
begin
  case
  when inserting then
    if upper(substr(:new.ap_paterno,1,1)) between 'A' and 'I'  then 
      -- Insertan en cliente_f1
      insert into cliente_f1( cliente_id, nombre, ap_paterno, ap_materno, 
        num_identificacion, email) 
      values( :new.cliente_id, :new.nombre, :new.ap_paterno, :new.ap_materno, 
        :new.num_identificacion, :new.email);

    elsif upper(substr(:new.ap_paterno,1,1)) between 'J' and 'Q'  then 
      -- Insertan en cliente_f2
      insert into cliente_f2( cliente_id, nombre, ap_paterno, ap_materno, 
        num_identificacion, email) 
      values( :new.cliente_id, :new.nombre, :new.ap_paterno, :new.ap_materno, 
        :new.num_identificacion, :new.email);

    elsif upper(substr(:new.ap_paterno,1,1)) between 'R' and 'Z'  then 
      -- Insertan en cliente_f3
      insert into cliente_f3( cliente_id, nombre, ap_paterno, ap_materno, 
        num_identificacion, email) 
      values( :new.cliente_id, :new.nombre, :new.ap_paterno, :new.ap_materno, 
        :new.num_identificacion, :new.email);

    else 
      -- No se cumple con las reglas del esquema de fragmentacion
      raise_application_error(-20010,
      'El ap_paterno ingresado es invalido: ' || :new.ap_paterno);
    end if;

  when updating then
    raise_application_error(-20030, 
      'La instruccion update no se encuentra implementada');

  when deleting then 
    --Completar
    if upper(substr(:old.ap_paterno,1,1)) between 'A' and 'I'  then 
      -- Insertan en cliente_f1
      delete from cliente_f1 where cliente_id = :old.cliente_id;

    elsif upper(substr(:old.ap_paterno,1,1)) between 'J' and 'Q'  then 
      -- Insertan en cliente_f2
      delete from cliente_f2 where cliente_id = :old.cliente_id;

    elsif upper(substr(:old.ap_paterno,1,1)) between 'R' and 'Z'  then 
      -- Insertan en cliente_f3
      delete from cliente_f3 where cliente_id = :old.cliente_id;
    end if;

  end case;
end;
/
