-- @Autor:          Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion:    Script encargado definir las vista para implementar
--                  Transparencia de fragmentacion

-- vista pais
create or replace view pais as 
select q1.pais_id, q1.clave, q1.nombre, q1.region_economica
from (
  select pais_id,clave, nombre, region_economica
  from pais_1
  union all
  select pais_id,clave, nombre, region_economica
  from pais_2
) q1;

-- vista suscriptor
create or replace view suscriptor as 
select q2.suscriptor_id, 
q2.nombre, q2.ap_paterno, q2.ap_materno, q2.fecha_inscripcion,
q2.num_tarjeta,q2.pais_id
from (
  select s1.suscriptor_id,num_tarjeta,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id 
  from suscriptor_1 s1
  join (
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from suscriptor_2
    union all 
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from suscriptor_3
    union all 
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from suscriptor_4
  ) sq1
  on sq1.suscriptor_id = s1.suscriptor_id
) q2;

-- vista revista
create or replace view revista as 
select q4.revista_id, q4.folio, q4.revista_adicional_id, q4.titulo, 
q4.fecha_publicacion
from (
  select revista_id,folio, revista_adicional_id, titulo, fecha_publicacion
  from revista_1
  union all
  select revista_id,folio, revista_adicional_id, titulo, fecha_publicacion
  from revista_2
) q4;

-- vista articulo_revista
create or replace view articulo_revista as 
select q5.articulo_revista_id, q5.fecha_aprobacion, q5.calificacion, 
q5.revista_id, q5.articulo_id
from (
  select articulo_revista_id,fecha_aprobacion, calificacion, 
  revista_id,articulo_id
  from articulo_revista_1
  union all
  select articulo_revista_id,fecha_aprobacion, calificacion, 
  revista_id,articulo_id
  from articulo_revista_2
) q5;
