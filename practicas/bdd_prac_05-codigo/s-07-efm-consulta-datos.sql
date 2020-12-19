--@Author:	        Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Conteo de datos en pc-efm

set linesize 700
prompt Conectado a sitio S1 - efmbd_s1

connect editorial_bdd/editorial_bdd@efmbd_s1

select  ( select count(*) from F_EFM_PAIS_1 ) pais_1, 
        ( select count(*) from F_EFM_SUSCRIPTOR_1) suscriptor_1, 
        ( select count(*) from F_EFM_SUSCRIPTOR_2) suscriptor_2, 
        ( select count(*) from F_EFM_SUSCRIPTOR_3) suscriptor_3, 
        ( select count(*) from F_EFM_ARTICULO_2) articulo_2,
        ( select count(*) from F_EFM_REVISTA_1) revista_1, 
        ( select count(*) from F_EFM_ARTICULO_REVISTA_1) articulo_revista_1, 
        ( select count(*) from F_EFM_PAGO_SUSCRIPTOR_1 ) pago_suscriptor_1
from dual;

prompt Conectando a S2 - efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2

select  ( select count(*) from F_EFM_PAIS_2 ) pais_2, 
        ( select count(*) from F_EFM_SUSCRIPTOR_4 ) suscriptor_4, 
        ( select count(*) from F_EFM_ARTICULO_1 ) articulo_1,
        ( select count(*) from F_EFM_REVISTA_2 ) revista_2, 
        ( select count(*) from F_EFM_ARTICULO_REVISTA_2 ) articulo_revista_2, 
        ( select count(*) from F_EFM_PAGO_SUSCRIPTOR_2 ) pago_suscriptor_2
from dual;
 

