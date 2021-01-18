--@Autor:           Rodrigo Francisco Pablo
--@Fecha creación:  18/01/2021
--@Descripción:     Creación de sinonimos -main
clear screen
whenever sqlerror exit rollback;

prompt =====================================
prompt Creando sinonimos para rfpbd_s1
prompt =====================================
connect autos_bdd/autos_bdd@rfpbd_s1
@s-04-autos-rfp-s1-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =====================================
prompt creando sinonimos para rfpbd_s2
prompt =====================================
connect autos_bdd/autos_bdd@rfpbd_s2
@s-04-autos-rfp-s2-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =====================================
prompt creando sinonimos para efmbd_s1
prompt =====================================
connect autos_bdd/autos_bdd@efmbd_s1
@s-04-autos-efm-s1-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt =====================================
prompt creando sinonimos para efmbd_s2
prompt =====================================
connect autos_bdd/autos_bdd@efmbd_s2
@s-04-autos-efm-s2-sinonimos.sql
@s-04-autos-valida-sinonimos.sql

prompt Listo!
disconnect
