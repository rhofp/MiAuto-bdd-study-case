--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/2020
--@Descripcion: Conteo de registros

set linesize 300

Prompt Conectando a S1 - rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

select ( select count(*) from pais ) pais, 
  ( select count(*) from suscriptor) suscriptor, 
  ( select count(*) from articulo) articulo,
  ( select count(*) from revista) revista, 
  ( select count(*) from articulo_revista) articulo_revista, 
  ( select count(*) from pago_suscriptor ) pago_suscriptor
from dual;

Prompt Conectando a S2 - rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

select ( select count(*) from pais ) pais, 
  ( select count(*) from suscriptor) suscriptor, 
  ( select count(*) from articulo) articulo,
  ( select count(*) from revista) revista, 
  ( select count(*) from articulo_revista) articulo_revista, 
  ( select count(*) from pago_suscriptor ) pago_suscriptor
from dual;
