--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/2020
--@Descripcion: Conteo de registros

set linesize 300

Prompt Conectando a S1 - rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

select ( select count(*) from F_RFP_PAIS_1 ) pais_1, 
( select count(*) from F_RFP_SUSCRIPTOR_1) suscriptor_1, 
( select count(*) from F_RFP_SUSCRIPTOR_2) suscriptor_2, 
( select count(*) from F_RFP_SUSCRIPTOR_3) suscriptor_3, 
-- TODO:- Revisar alias con el profesor
-- ( select count(*) from F_RFP_ARTICULO_2) articulo_1,
( select count(*) from F_RFP_ARTICULO_2) articulo_2,
( select count(*) from F_RFP_ARTICULO_REVISTA_1) articulo_1,
( select count(*) from F_RFP_REVISTA_1) revista_1, 
-- TODO:- Revisar alias con el profesor  
-- ( select count(*) from F_RFP_ARTICULO_REVISTA_1) revista_2, 
( select count(*) from F_RFP_ARTICULO_REVISTA_1) articulo_revista_1, 
( select count(*) from F_RFP_PAGO_SUSCRIPTOR_1 ) pago_suscriptor_1
from dual;

Prompt Conectando a S2 - rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

select ( select count(*) from F_RFP_PAIS_2 ) pais_2, 
( select count(*) from F_RFP_SUSCRIPTOR_4 ) suscriptor_4, 
( select count(*) from F_RFP_ARTICULO_1 ) articulo_1,
( select count(*) from F_RFP_REVISTA_2 ) revista_2, 
( select count(*) from F_RFP_ARTICULO_REVISTA_2 ) articulo_revista_2, 
( select count(*) from F_RFP_PAGO_SUSCRIPTOR_2 ) pago_suscriptor_2
from dual;