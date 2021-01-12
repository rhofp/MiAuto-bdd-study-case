--@Autor: Francisco Pablo Rodrigo
--@Fecha creación: dd/mm/yyyy
--@Descripción: Creación de triggers

whenever sqlerror exit rollback

Prompt =================================
Prompt creando triggers en S1
connect editorial_bdd/editorial_bdd@rfpbd_s1
Prompt =================================

Prompt creando trigger para pais
@s-03-rfp-pais-trigger.sql
show errors

Prompt creando trigger para suscriptor
@s-03-rfp-suscriptor-n1-trigger.sql
show errors

Prompt creando trigger para pago_suscriptor
@s-03-rfp-pago-suscriptor-n1-trigger.sql
show errors

Prompt creando trigger para articulo
@s-03-rfp-articulo-n1-trigger.sql
show errors

Prompt =================================
Prompt creando triggers en S2
connect editorial_bdd/editorial_bdd@rfpbd_s2
Prompt =================================

Prompt creando trigger para pais
@s-03-rfp-pais-trigger.sql
show errors

Prompt creando trigger para suscriptor
@s-03-rfp-suscriptor-n2-trigger.sql
show errors

Prompt creando trigger para pago_suscriptor
@s-03-rfp-pago-suscriptor-n2-trigger.sql
show errors

Prompt creando trigger para articulo
@s-03-rfp-articulo-n2-trigger.sql
show errors

Prompt Listo!
exit
