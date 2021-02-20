--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   24/01/2021
--@Descripcion:         Script principal empleado para configurar el soporte
--                      de datos BLOB en los 4 nodos.

Prompt configurando directorios y otorgando registros.

--rfpbd_s1
Prompt configurando soporte BLOB para rfpbd_s1
connect autos_bdd/autos_bdd@rfpbd_s1
@s-07-autos-configuracion-soporte-blobs.sql

--rfpbd_s2
Prompt configurando soporte BLOB para rfpbd_s2
connect autos_bdd/autos_bdd@rfpbd_s2
@s-07-autos-configuracion-soporte-blobs.sql

--efmbd_s1
Prompt configurando soporte BLOB para efmbd_s1
connect autos_bdd/autos_bdd@efmbd_s1
@s-07-autos-configuracion-soporte-blobs.sql

--efmbd_s2
Prompt configurando soporte BLOB para efmbd_s2
connect autos_bdd/autos_bdd@efmbd_s2
@s-07-autos-configuracion-soporte-blobs.sql

Prompt Listo !
Disconnect