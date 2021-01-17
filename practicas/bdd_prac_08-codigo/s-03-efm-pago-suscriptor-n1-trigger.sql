--@Author:	    Emanuel Flores Martinez
--@Fecha creacion:  16/01/2021
--@Descripcion:     Trigger instead of para la vista pago_suscriptor n1

create or replace trigger t_dml_pago_suscriptor
instead of insert or update or delete on pago_suscriptor
declare
  v_count number;
begin
  case 
    when inserting then
      if :new.num_pago > 0 and :new.num_pago <= 60 then
        insert into pago_suscriptor_1 (num_pago, suscriptor_id,
          fecha_pago, importe, recibo_pago) 
        values (:new.num_pago, :new.suscriptor_id, :new.fecha_pago,
          :new.importe, :new.recibo_pago);
      
      elsif :new.num_pago > 60 then
        -- insercion remota, se hce uso de la tabla temporal por BLOB
        
        insert into t_pago_suscriptor_insert (num_pago, suscriptor_id,
          fecha_pago, importe, recibo_pago) 
        values (:new.num_pago, :new.suscriptor_id, :new.fecha_pago,
          :new.importe, :new.recibo_pago);

        insert into pago_suscriptor_2
          select * from t_pago_suscriptor_insert
          where num_pago = :new.num_pago
          and suscriptor_id = :new.suscriptor_id;
        
        delete from t_pago_suscriptor_insert
        where num_pago = :new.num_pago
        and suscriptor_id = :new.suscriptor_id;

      else
        raise_application_error(-20001, 
          'Valor de num_pago ' || :new.num_pago || ' no es valido');
      end if;

    when deleting then 
      if :old.num_pago > 0 and :old.num_pago <= 60 then
        delete from pago_suscriptor_1 
        where num_pago = :old.num_pago
        and suscriptor_id = :old.suscriptor_id;

      elsif :old.num_pago > 60 then
        delete from pago_suscriptor_2 
        where num_pago = :old.num_pago
        and suscriptor_id = :old.suscriptor_id;

      else 
        raise_application_error(-20001, 
          'El numero de pago debe ser valido');
      
      end if;
      
    when updating then 
      raise_application_error(-20002, 
        'Error, sentencia UPDATE no soportada');

  end case;
end; 
/
