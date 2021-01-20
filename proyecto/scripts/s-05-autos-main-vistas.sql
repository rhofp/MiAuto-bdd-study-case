--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   20/01/2021
--@Descripcion:         Creacion de vistas para todos los sitios

clear screen
whenever sqlerror exit rollback;

prompt ===========================================
prompt Creando vistas para rfpbd_s1
prompt ===========================================

connect autos_bdd/autos_bdd@rfpbd_s1
prompt creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt creando vistas con soporte para BLOBs
@s-05-autos-rfp-s1-vistas-blob.sql

prompt ===========================================
prompt Creando vistas para rfpbd_s2
prompt ===========================================

connect autos_bdd/autos_bdd@rfpbd_s2
prompt creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt creando vistas con soporte para BLOBs
@s-05-autos-rfp-s2-vistas-blob.sql

prompt ===========================================
prompt Creando vistas para efmbd_s1
prompt ===========================================

connect autos_bdd/autos_bdd@efmbd_s1
prompt creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt creando vistas con soporte para BLOBs
@s-05-autos-efm-s1-vistas-blob.sql

prompt ===========================================
prompt Creando vistas para efmbd_s2
prompt ===========================================

connect autos_bdd/autos_bdd@efmbd_s2
prompt creando vistas que no requieren manejo de BLOBs
@s-05-autos-vistas.sql

prompt creando tablas temporales
@s-05-autos-tablas-temporales.sql

prompt creando objetos para manejo de BLOBs
@s-05-autos-funciones-blob.sql

prompt creando vistas con soporte para BLOBs
@s-05-autos-efm-s2-vistas-blob.sql

prompt Listo!
disconnect