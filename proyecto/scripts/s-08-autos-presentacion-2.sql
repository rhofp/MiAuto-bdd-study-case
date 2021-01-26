--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   24/01/2021
--@Descripcion:         efmhivo de carga inicial para poblado manual de datos

clear screen
whenever sqlerror exit rollback;

Prompt ======================================
Prompt Cargando catalogos replicados en rfpbd_s1
Prompt ======================================
connect autos_bdd/autos_bdd@rfpbd_s1
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ======================================
Prompt Cargando catalogos replicados en rfpbd_s2
Prompt ======================================
connect autos_bdd/autos_bdd@rfpbd_s2
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ======================================
Prompt Cargando catalogos replicados en efmbd_s1
Prompt ======================================
connect autos_bdd/autos_bdd@efmbd_s1
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt ======================================
Prompt Cargando catalogos replicados en efmbd_s2
Prompt ======================================
connect autos_bdd/autos_bdd@efmbd_s2
delete from status_auto;
@carga-inicial/status_auto.sql

Prompt Haciendo Commit de todos los datos !
commit;
Prompt Listo !
exit