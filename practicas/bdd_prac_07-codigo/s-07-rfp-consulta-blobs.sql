--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/2020
--@Descripcion: Consulta blobs con transparencia de fragmentacion

set serveroutput on

Prompt Conectandose a rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

Prompt articulo estrategia 1
select articulo_id,dbms_lob.getlength(pdf) as longitud
from articulo_e1;

Prompt articulo estrategia 2
select articulo_id,dbms_lob.getlength(pdf) as longitud
from articulo_e2;

Prompt articulo, uso de sinonimo
select articulo_id,dbms_lob.getlength(pdf) as longitud
from articulo;

Prompt suscriptor estrategia 1
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e1;

Prompt suscriptor estrategia 2
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e2;

Prompt suscriptor, uso de sinonimo
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor;

Prompt Conectandose a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

-- En este sitio solo se usa la vista ya que el dato BLOB se encuentra de forma local.
Prompt articulo uso de la vista (acceso local al dato BLOB)
select articulo_id,dbms_lob.getlength(pdf) as longitud
from articulo;

Prompt suscriptor estrategia 1
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e1;

Prompt suscriptor estrategia 2
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e2;

Prompt suscriptor, uso de sinonimo
select suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor;

Prompt Listo!
exit

