-- @Autor:          Francisco Pablo Rodrigo
-- @Fecha creacion: 01/01/2021
-- @Descripcion:    Definicion de trigger instead of para la vista suscriptor
--                  para el nodo 1

create or replace trigger t_dml_suscriptor 
instead of insert or update or delete on suscriptor
declare
  v_count number;
begin
  case 
    when inserting then
			
			--verifica si hay correspondencia local para evitar acceso remoto
			select count(*) into v_count
			from pais_1 
			where pais_id =:new.pais_id;
			--insercion local en suscriptor_2
			if v_count > 0 then
				insert into suscriptor_2(suscriptor_id,nombre,ap_paterno,ap_materno,
          fecha_inscripcion,pais_id)
				values(:new.suscriptor_id,:new.nombre,:new.ap_paterno,:new.ap_materno,
          :new.fecha_inscripcion,:new.pais_id);	

      -- A continuacion siguen 2 casos mas, para ambos se toma como referencia
      -- pais_2. Sin embargo, el fragmento derivado se vuelve a dividir tomando
      -- como base el ap_paterno, por lo tanto:
      -- Si pais_id pertence a pais_2 se debe comprobar 
      --    Si la primera letra de ap_paterno se encuentra entre 'A' y 'M'
      --      Se inserta en suscriptor_3 (FRAGMENTO LOCAL)
      --    Si la primera letra de ap_paterno se encuentra entre 'N' y 'Z'
      --      Se inserta en suscriptor_4 (FRAGMENTO REMOTO)
      -- NO olvidar que siempre se inserta en suscriptor_1 dado que es un
      -- fragmento vertical
			else 
				select count(*) into v_count
				from pais_2 
				where pais_id =:new.pais_id;
				if v_count > 0 then
          if substr(:new.ap_paterno,1,1) between 'A' and 'M' then 
            -- Insertar  suscriptor_3
            insert into suscriptor_3(suscriptor_id,nombre,ap_paterno,
              ap_materno, fecha_inscripcion,pais_id)
            values(:new.suscriptor_id,:new.nombre,:new.ap_paterno,
              :new.ap_materno, :new.fecha_inscripcion,:new.pais_id);	

          elsif substr(:new.ap_paterno,1,1) between 'N' and 'Z' then 
            -- Insertar suscriptor_4
            insert into suscriptor_4(suscriptor_id,nombre,ap_paterno,
              ap_materno, fecha_inscripcion,pais_id)
            values(:new.suscriptor_id,:new.nombre,:new.ap_paterno,
              :new.ap_materno, :new.fecha_inscripcion,:new.pais_id);	

          else
            raise_application_error(-20001,'El apellido paterno es invalido');
          end if;
			 	else
			 		raise_application_error(-20001, 
                		'Error de integridad para el campo pais_id : '
                		||  :new.pais_id
                		|| ' No se encontro el registro padre en fragmentos');   
			 	end if;
			end if;

      insert into suscriptor_1(suscriptor_id,num_tarjeta)
      values(:new.suscriptor_id,:new.num_tarjeta);	


    when deleting then
			--verifica si hay correspondencia local para evitar acceso remoto
			select count(*) into v_count
			from pais_1 
			where pais_id =:old.pais_id;
			--eliminacion local en suscriptor_2
			if v_count > 0 then
        delete from suscriptor_2 where suscriptor_id = : old.suscriptor_id;
      -- Que suscriptor se fragmente con pais_2 no implica necesariamente que
      -- este en un sitio remoto.
      -- El segundo criterio es el ap_paterno
			else 
				select count(*) into v_count
				from pais_2 
				where pais_id =:old.pais_id;
				if v_count > 0 then
          if substr(:old.ap_paterno,1,1) between 'A' and 'M' then 
            -- Borrar en suscriptor_3 
            delete from suscriptor_3 where suscriptor_id = :old.suscriptor_id;
          elsif substr(:old.ap_paterno,1,1) between 'N' and 'Z' then 
            -- Borrar en suscriptor_4 (Fragmento REMOTO)
            delete from suscriptor_4 where suscriptor_id = :old.suscriptor_id;
          else
            raise_application_error(-20001,'El apellido paterno es invalido');
          end if;
			 	else
			 		raise_application_error(-20001, 
                		'Error de integridad para el campo pais_id : '
                		||  :old.pais_id
                		|| ' No se encontro el registro padre en fragmentos');   
			 	end if;
			end if;

      delete from suscriptor_1 where suscriptor_id = :old.suscriptor_id;

    when updating then 
      raise_application_error(-20002,
        'La instrccion update aun no se implementa');
       
  end case;

end;
/
show errors
