--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Definición de vistas se pueede ejecutar en cualquer PDB

-- View para PAIS
create or replace view pais as 
  select pais_id, clave, nombre, region_economica from pais_1 
  union all 
  select pais_id, clave, nombre, region_economica from pais_2;

-- View para SUSCRIPTOR
create or replace view suscriptor as 
  select s1.suscriptor_id, s2.nombre, s2.ap_paterno, s2.ap_materno, 
  s2.fecha_inscripcion, s1.num_tarjeta, s2.pais_id 
  from (
    select suscriptor_id, nombre, ap_paterno, ap_materno,
    fecha_inscripcion, pais_id from suscriptor_2
    union all 
    select suscriptor_id, nombre, ap_paterno, ap_materno,
    fecha_inscripcion, pais_id from suscriptor_3
    union all
    select suscriptor_id, nombre, ap_paterno, ap_materno,
    fecha_inscripcion, pais_id from suscriptor_4
  ) s2  join suscriptor_1 s1 
  on s1.suscriptor_id = s2.suscriptor_id;

-- View para REVISTA
create or replace view revista as
  select revista_id, folio, titulo, fecha_publicacion, revista_adicional_id
  from revista_1
  union all 
  select revista_id, folio, titulo, fecha_publicacion, revista_adicional_id
  from revista_2;

-- View para ARTICULO_REVISTA
create or replace view articulo_revista as 
  select articulo_revista_id, fecha_aprobacion, calificacion, articulo_id, revista_id
  from articulo_revista_1
  union all
  select articulo_revista_id, fecha_aprobacion, calificacion, articulo_id, revista_id
  from articulo_revista_2;