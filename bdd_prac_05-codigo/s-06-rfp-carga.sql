--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/2020
--@Descripcion: Archivo de carga inicial en rfp-pc

Prompt Conectando a S1 - rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1
--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;

Prompt limpiando.
--delete from ...
delete from F_RFP_PAIS_1;
delete from F_RFP_SUSCRIPTOR_1;
delete from F_RFP_SUSCRIPTOR_2;
delete from F_RFP_SUSCRIPTOR_3;
delete from F_RFP_REVISTA_1;
delete from F_RFP_ARTICULO_2;
delete from F_RFP_ARTICULO_REVISTA_1;
delete from F_RFP_PAGO_SUSCRIPTOR_1;

Prompt Cargando datos
--insert into ..
-- Insercion de paises
insert into F_RFP_PAIS_1 (pais_id,clave,nombre,region_economica) values();

-- Insercion de suscriptores 1
insert into F_RFP_SUSCRIPTOR_1 (suscriptor_id,num_tarjeta)  values ();

-- Insercion de suscriptores 2
insert into F_RFP_SUSCRIPTOR_2 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values ();

-- Insercion de suscriptores 3
insert into F_RFP_SUSCRIPTOR_3 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values ();

-- Insercion en revista 1
insert into F_RFP_REVISTA_1 (
  revista_id,folio,revista_adicional_id,titulo,fecha_publicacion
) values ();

-- insercion en articulo 2
insert into F_RFP_ARTICULO_2 (
  articulo_id, titulo, resumen, texto
) values ();

-- Insercion en articulo_revista 1
insert into F_RFP_ARTICULO_REVISTA_1 (
  articulo_revista_id, fecha_aprobacion,calificacion
  revista_id, articulo_id
) values ();

-- Insercion en pago_suscriptor 1
insert into F_RFP_PAGO_SUSCRIPTOR_1 (
  num_pago, suscriptor_id, fecha_pago, importe,recibo_pago
) values ();


--hacer commit al terminar
commit;

Prompt Conectando a S2 - rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2
--si ocurre un error, la ejecución se detiene.

whenever sqlerror exit rollback;

Prompt limpiando.
--delete from ...
delete from F_RFP_PAIS_2;
delete from F_RFP_SUSCRIPTOR_4;
delete from F_RFP_ARTICULO_1;
delete from F_RFP_REVISTA_2;
delete from F_RFP_ARTICULO_REVISTA_2;
delete from F_RFP_PAGO_SUSCRIPTOR_2;

Prompt Cargando datos
--insert into ..

-- Insercion de pais 2
insert into F_RFP_PAIS_2 (pais_id,clave,nombre,region_economica) values();

-- Insercion de suscriptores 4
insert into F_RFP_SUSCRIPTOR_4 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values ();

-- Insercion en revista 2
insert into F_RFP_REVISTA_2 (
  revista_id,folio,revista_adicional_id,titulo,fecha_publicacion
) values ();

-- insercion en articulo 1
insert into F_RFP_ARTICULO_1 (
  pdf
) values ();

-- Insercion en articulo_revista 2
insert into F_RFP_ARTICULO_REVISTA_2 (
  articulo_revista_id, fecha_aprobacion,calificacion
  revista_id, articulo_id
) values ();

-- Insercion en pago_suscriptor 2
insert into F_RFP_PAGO_SUSCRIPTOR_2 (
  num_pago, suscriptor_id, fecha_pago, importe,recibo_pago
) values ();

--hacer commit al terminar
commit;

Prompt Listo!
exit