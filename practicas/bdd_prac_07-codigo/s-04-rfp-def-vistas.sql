-- @Autor:          Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion:    Script encargado definir las vista para implementar
--                  Transparencia de fragmentacion

-- Vista pais
create or replace view pais as 
select q1.pais_id, q1.clave, q1.nombre, q1.region_economica
from (
  select pais_id,clave, nombre, region_economica
  from PAIS_1
  union all
  select pais_id,clave, nombre, region_economica
  from PAIS_2
) q1;

-- Vista suscriptor
create or replace view suscriptor as 
select q2.suscriptor_id, 
q2.nombre, q2.ap_paterno, q2.ap_materno, q2.fecha_inscripcion,
q2.num_tarjeta
from (
  select s1.suscriptor_id,num_tarjeta,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id 
  from SUSCRIPTOR_1 s1
  join (
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from SUSCRIPTOR_2
    union all 
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from SUSCRIPTOR_3
    union all 
    select suscriptor_id,nombre, ap_paterno, ap_materno, 
    fecha_inscripcion, pais_id
    from SUSCRIPTOR_4
  ) sq1
  on sq1.suscriptor_id = s1.suscriptor_id
) q2;

-- Vista revista
create or replace view revista as 
select q4.revista_id, q4.folio, q4.revista_adicional_id, q4.titulo, 
q4.fecha_publicacion
from (
  select revista_id,folio, revista_adicional_id, titulo, fecha_publicacion
  from REVISTA_1
  union all
  select revista_id,folio, revista_adicional_id, titulo, fecha_publicacion
  from REVISTA_2
) q4;

-- Vista articulo_revista
create or replace view articulo_revista as 
select q5.articulo_revista_id, q5.fecha_aprobacion, q5.calificacion, 
q5.revista_id, q5.articulo_id
from (
  select articulo_revista_id,fecha_aprobacion, calificacion, 
  revista_id,articulo_id
  from ARTICULO_REVISTA_1
  union all
  select articulo_revista_id,fecha_aprobacion, calificacion, 
  revista_id,articulo_id
  from ARTICULO_REVISTA_2
) q5;
