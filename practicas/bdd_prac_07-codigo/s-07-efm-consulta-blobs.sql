--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  17/12/2020
--@Descripción:     Consultas para validar vistas con columnas BLOB

prompt Conectandose a efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1

-- Consulta para articulo
prompt articulo estrategia 1
select articulo_id, dbms_lob.getlength(pdf) as longitud
from articulo_e1;

prompt articulo estrategia 2
select articulo_id, dbms_lob.getlength(pdf) as longitud
from articulo_e2;

prompt articulo, uso de sinonimo
select articulo_id, dbms_lob.getlength(pdf) as longitud
from articulo;

-- Consulta para pago_suscriptor
prompt pago_suscriptor estrategia 1
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e1;

prompt pago_suscriptor estrategia 2
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e2;

prompt pago_suscriptor, uso de sinonimo
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor;


prompt Conectandose a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2

prompt articulo uso de la vista (acceso local al dato BLOB)
select articulo_id, dbms_lob.getlength(pdf) as longitud
from articulo;

-- Consulta para pago_suscriptor
prompt pago_suscriptor estrategia 1
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e1;

prompt pago_suscriptor estrategia 2
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor_e2;

prompt pago_suscriptor, uso de sinonimo
select num_pago, suscriptor_id, dbms_lob.getlength(recibo_pago) as longitud
from pago_suscriptor;

Prompt Listo!
exit
