-- @Autor:          Francisco Pablo Rodrigo
-- @Fecha creacion: 01/01/2021
-- @Descripcion:    Definicion de trigger instead of para la vista
--                  pago_suscriptor para el nodo 1

create or replace trigger t_dml_pago_suscriptor 
instead of insert or delete or update on pago_suscriptor
declare
  v_count number;
begin
  case 
    when inserting then
      if :new.num_pago >= 1 and :new.num_pago <= 60 then 
        -- Se inserta de manera local dado que estamos en n1
        insert into pago_suscriptor_1(num_pago,suscriptor_id,fecha_pago,importe, 
          recibo_pago)
        values(:new.num_pago,:new.suscriptor_id,:new.fecha_pago,:new.importe, 
          :new.recibo_pago);

      elsif :new.num_pago > 60 then 
        -- Se inserta de manera remota dado que estamos en n1

        -- Haciendo uso de la tabla temporal
        insert into t_pago_suscriptor_insert(num_pago,suscriptor_id,fecha_pago,importe, 
          recibo_pago)
        values(:new.num_pago,:new.suscriptor_id,:new.fecha_pago,:new.importe, 
          :new.recibo_pago);

        -- Insercion por en el sitio remoto por medio de la tabla temporal 
        insert into pago_suscriptor_2
          select * from t_pago_suscriptor_insert 
          where num_pago = :new.num_pago 
          and suscriptor_id = :new.suscriptor_id;

        delete from t_pago_suscriptor_insert 
        where num_pago = :new.num_pago 
        and suscriptor_id = :new.suscriptor_id;

      else 
        raise_application_error(-20001,'El num_pago es invalido');
      end if;

    when deleting then
      if :old.num_pago >= 1 and :old.num_pago <= 60 then 
        delete from pago_suscriptor_1
        where num_pago = :old.num_pago 
        and suscriptor_id = :old.suscriptor_id;
      elsif :old.num_pago > 60 then 
        delete from pago_suscriptor_2
        where num_pago = :old.num_pago 
        and suscriptor_id = :old.suscriptor_id;
      else 
        raise_application_error(-20001,'El num_pago es invalido');
      end if;

    when updating then 
      raise_application_error(-20002,
        'La instrccion update aun no se implementa');
       
  end case;
end;
/
			
