-- @Autor:          Francisco Pablo Rodrigo
-- @Fecha creacion: 01/01/2021
-- @Descripcion:    Definicion de trigger instead of para la vista
--                  articulo para el nodo 2

create or replace trigger t_dml_articulo 
instead of insert or delete or update on articulo
declare
  v_count number;
begin
  -- En todos los casos se hace uso de los 2 fragmentos. Cada uno se encuentra
  -- en un sitio
  case 
    when inserting then

      insert into articulo_1(articulo_id,pdf)
      values(:new.articulo_id,:new.pdf);

      insert into articulo_2(articulo_id,titulo,resumen,texto)
      values(:new.articulo_id,:new.titulo,:new.resumen,:new.texto);

    when deleting then
      -- Se debe eliminar en ambos fragmentos dado que es una fragmentacion
      -- vertical
      delete from articulo_1 
      where articulo_id = :old.articulo_id;

      delete from articulo_2 
      where articulo_id = :old.articulo_id;

    when updating then
      raise_application_error(-20002,
        'La instrccion update aun no se implementa');

  end case;
end;
/
show errors
