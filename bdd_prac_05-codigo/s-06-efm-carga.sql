--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Archivo de carga inicial en pc-efm

Prompt Conectando a S1 - efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1

--si ocurre un error, la ejecución se detiene.
whenever sqlerror exit rollback;

Prompt limpiando.
--delete from ...
delete from F_EFM_PAIS_1;
delete from F_EFM_SUSCRIPTOR_1;
delete from F_EFM_SUSCRIPTOR_2;
delete from F_EFM_SUSCRIPTOR_3;
delete from F_EFM_REVISTA_1;
delete from F_EFM_ARTICULO_2;
delete from F_EFM_ARTICULO_REVISTA_1;
delete from F_EFM_PAGO_SUSCRIPTOR_1;

Prompt Cargando datos
--insert into ..
-- Insercion de paises
insert into F_EFM_PAIS_1 (pais_id,clave,nombre,region_economica) 
values(1,'MX','MEXICO','A');

-- Insercion de suscriptores 1
insert into F_EFM_SUSCRIPTOR_1 (suscriptor_id,num_tarjeta)  
values (1,5420900754028724);

insert into F_EFM_SUSCRIPTOR_1 (suscriptor_id,num_tarjeta)  
values (2,5800807976301529);

insert into F_EFM_SUSCRIPTOR_1 (suscriptor_id,num_tarjeta)  
values (3,6202870129036021);

-- Insercion de suscriptores 2
insert into F_EFM_SUSCRIPTOR_2 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values (1,'OMAR','LIPEZ','MENDEZ',to_date('01/01/2017','DD/MM/YYYY'),1);

-- Insercion de suscriptores 3
insert into F_EFM_SUSCRIPTOR_3 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values (2,'LALO','KIM','LUNA',to_date('01/01/2016','DD/MM/YYYY'),2);

-- Insercion en revista 1
insert into F_EFM_REVISTA_1 (
  revista_id,folio,titulo,fecha_publicacion,revista_adicional_id
) values (1,'90001','Premier',to_date('01/03/2017','DD/MM/YYYY'),null);

-- insercion en articulo 2
insert into F_EFM_ARTICULO_2 (
  articulo_id, titulo, resumen, texto
) values (1,'LOS SISMOS','Estudio y origen de los sismos',
'Texto de ejemplo para el artículo');

insert into F_EFM_ARTICULO_2 (
  articulo_id, titulo, resumen, texto
) values (2,'FAUNA MARINA','Estudio de la fauna marina de México.',
'Texto de ejemplo para el artículo');

-- Insercion en articulo_revista 1
insert into F_EFM_ARTICULO_REVISTA_1 (
  articulo_revista_id, articulo_id, revista_id, fecha_aprobacion, calificacion
) values (1,1,1,to_date('01/02/2017','DD/MM/YYYY'),9);

-- Insercion en pago_suscriptor 1
insert into F_EFM_PAGO_SUSCRIPTOR_1 (
  num_pago, suscriptor_id, fecha_pago, importe,recibo_pago
) values (1,1,to_date('01/02/2017','DD/MM/YYYY'),989.67,empty_blob());


--hacer commit al terminar
commit;

Prompt Conectando a S2 - efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2
--si ocurre un error, la ejecución se detiene.

whenever sqlerror exit rollback;

Prompt limpiando.
--delete from ...
delete from F_EFM_PAIS_2;
delete from F_EFM_SUSCRIPTOR_4;
delete from F_EFM_ARTICULO_1;
delete from F_EFM_REVISTA_2;
delete from F_EFM_ARTICULO_REVISTA_2;
delete from F_EFM_PAGO_SUSCRIPTOR_2;

Prompt Cargando datos
--insert into ..

-- Insercion de pais 2
insert into F_EFM_PAIS_2 (pais_id,clave,nombre,region_economica) 
values(2,'JAP','JAPON','B');

-- Insercion de suscriptores 4
insert into F_EFM_SUSCRIPTOR_4 (
  suscriptor_id,nombre,ap_paterno,ap_materno,fecha_inscripcion,pais_id
) values (3,'LUCY','ZAMORA','PEREZ',to_date('01/01/2015','DD/MM/YYYY'),2);

-- Insercion en revista 2
insert into F_EFM_REVISTA_2 (
  revista_id,folio,titulo,fecha_publicacion,revista_adicional_id
) values (2,'90002','TI en la UNAM',to_date('01/09/2017','DD/MM/YYYY'),1);

-- insercion en articulo 1
insert into F_EFM_ARTICULO_1 (
  articulo_id,pdf
) values (1,empty_blob());

insert into F_EFM_ARTICULO_1 (
  articulo_id,pdf
) values (2,empty_blob());

-- Insercion en articulo_revista 2
insert into F_EFM_ARTICULO_REVISTA_2 (
  articulo_revista_id,articulo_id,revista_id, fecha_aprobacion,calificacion 
) values (2,2,2,to_date('01/08/2017','DD/MM/YYYY'),10);

-- Insercion en pago_suscriptor 2
insert into F_EFM_PAGO_SUSCRIPTOR_2 (
  num_pago, suscriptor_id, fecha_pago, importe,recibo_pago
) values (70,2,to_date('01/08/2017','DD/MM/YYYY'),1000.55,empty_blob());

--hacer commit al terminar
commit;

Prompt Listo!
exit

