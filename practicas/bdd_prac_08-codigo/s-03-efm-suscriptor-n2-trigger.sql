--@Author:	    Emanuel Flores Martinez
--@Fecha creacion:  16/01/2021
--@Descripcion:     Trigger instead of para la vista suscriptor n2

create or replace trigger t_dml_suscriptor
instead of insert or update or delete on suscriptor
declare
  v_count number;
begin
  case 
    when inserting then
      
      --verifica si hay correspondencia local para evitar acceso remoto
			select count(*) into v_count
			from pais_2
			where pais_id =:new.pais_id;

      if v_count > 0 then
        if substr(:new.ap_paterno, 1, 1) between 'A' and 'M' then

          insert into suscriptor_3(suscriptor_id, nombre, ap_paterno, 
              ap_materno, fecha_inscripcion, pais_id)
            values(:new.suscriptor_id, :new.nombre, :new.ap_paterno, 
              :new.ap_materno, :new.fecha_inscripcion, :new.pais_id);

        elsif substr(:new.ap_paterno, 1, 1) between 'N' and 'Z' then

          insert into suscriptor_4 (suscriptor_id, nombre, ap_paterno, 
            ap_materno, fecha_inscripcion, pais_id)
          values(:new.suscriptor_id, :new.nombre, :new.ap_paterno, 
            :new.ap_materno, :new.fecha_inscripcion, :new.pais_id);

        else
          raise_application_error(-20001, 
            'Error ' || :new.ap_paterno || ' no es valido');

        end if;

      else
        select count(*) into v_count
        from pais_1 
        where pais_id =:new.pais_id;

        --insercion local
        if v_count > 0 then
          insert into suscriptor_2(suscriptor_id, nombre, ap_paterno, 
            ap_materno, fecha_inscripcion, pais_id)
          values(:new.suscriptor_id, :new.nombre, :new.ap_paterno, 
            :new.ap_materno, :new.fecha_inscripcion, :new.pais_id);	
        
        else
			 		raise_application_error(-20001, 
              'Error de integridad para el campo pais_id : '
              ||  :new.pais_id
              || ' No se encontro el registro padre en fragmentos');   
			 	end if;
      end if;

      insert into suscriptor_1 (suscriptor_id, num_tarjeta)
      values (:new.suscriptor_id, :new.num_tarjeta);
    
    when deleting then
      select count(*) into v_count
			from pais_2
			where pais_id = :old.pais_id;

      if v_count > 0 then
        if substr(:old.ap_paterno, 1, 1) between 'A' and 'M' then
          delete from suscriptor_3 
          where suscriptor_id = :old.suscriptor_id;
        
        elsif substr(:old.ap_paterno, 1, 1) between 'N' and 'Z' then
          delete from suscriptor_4
          where suscriptor_id = :old.suscriptor_id;
        
        else
          raise_application_error(-20001, 
            'Valor incorrecto para el campo apellido paterno');
        end if;
      else 
        delete from suscriptor_2 
        where suscriptor_id = :old.suscriptor_id;
      end if;

      delete from suscriptor_1 where suscriptor_id = :old.suscriptor_id;
    
    when updating then
      raise_application_error(-20002, 
        'Error, sentencia UPDATE no soportada');
  
  end case;
end;
/
