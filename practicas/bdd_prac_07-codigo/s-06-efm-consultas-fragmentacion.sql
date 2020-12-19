--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  17/12/2020
--@Descripción:     Conteo de datos en pc-efm

set linesize 700

prompt Conectado a sitio s1
connect editorial_bdd/editorial_bdd@efmbd_s1
prompt Realizando conteo de registros

select  ( select count(*) from pais) PAIS,
        ( select count(*) from suscriptor) SUSCRIPTOR,
        ( select count(*) from articulo) ARTICULO,
        ( select count(*) from revista) REVISTA,
        ( select count(*) from articulo_revista) ARTICULO_REVISTA,
        ( select count(*) from pago_suscriptor) PAGO_SUSCRIPTOR
from dual;

prompt Conectado a sitio s2
connect editorial_bdd/editorial_bdd@efmbd_s2
prompt Realizando conteo de registros

select  ( select count(*) from pais) PAIS,
        ( select count(*) from suscriptor) SUSCRIPTOR,
        ( select count(*) from articulo) ARTICULO,
        ( select count(*) from revista) REVISTA,
        ( select count(*) from articulo_revista) ARTICULO_REVISTA,
        ( select count(*) from pago_suscriptor) PAGO_SUSCRIPTOR
from dual;

prompt Listo!
exit