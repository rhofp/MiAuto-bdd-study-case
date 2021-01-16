--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  16/01/2021
--@Descripción:     Ejecución de triggers

whenever sqlerror exit rollback

Prompt =================================
Prompt creando triggers en S1
connect editorial_bdd/editorial_bdd@efmbd_s1
Prompt =================================

Prompt creando trigger para pais
@s-03-efm-pais-trigger.sql
show errors

Prompt creando trigger para suscriptor
@s-03-efm-suscriptor-n1-trigger.sql
show errors

Prompt creando trigger para pago_suscriptor
@s-03-efm-pago-suscriptor-n1-trigger.sql
show errors

Prompt creando trigger para articulo
@s-03-efm-articulo-n1-trigger.sql
show errors

Prompt =================================
Prompt creando triggers en S2
connect editorial_bdd/editorial_bdd@efmbd_s2
Prompt =================================

Prompt creando trigger para pais
@s-03-efm-pais-trigger.sql
show errors

Prompt creando trigger para suscriptor
@s-03-efm-suscriptor-n2-trigger.sql
show errors

Prompt creando trigger para pago_suscriptor
@s-03-efm-pago-suscriptor-n2-trigger.sql
show errors

Prompt creando trigger para articulo
@s-03-efm-articulo-n2-trigger.sql
show errors

Prompt Listo!
exit