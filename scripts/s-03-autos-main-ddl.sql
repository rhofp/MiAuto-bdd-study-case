--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   14/01/2021
--@Descripcion:         Creacion de fragmentos en los 4 nodos

clear screen
whenever sqlerror exit rollback;
prompt =====================================
prompt Creando fragmentos para rfpbd_s1
prompt =====================================
connect autos_bdd/autos_bdd@rfpbd_s1
@s-03-autos-rfp-s1-ddl.sql

prompt =====================================
prompt Creando fragmentos para rfpbd_s2
prompt =====================================
connect autos_bdd/autos_bdd@rfpbd_s2
@s-03-autos-rfp-s2-ddl.sql

prompt =====================================
prompt Creando fragmentos para efmbd_s1
prompt =====================================
connect autos_bdd/autos_bdd@efmbd_s1
@s-03-autos-efm-s1-ddl.sql

prompt =====================================
prompt Creando fragmentos para efmbd_s2
prompt =====================================
connect autos_bdd/autos_bdd@efmbd_s2
@s-03-autos-efm-s2-ddl.sql

Prompt Listo!
