--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   24/01/2021
--@Descripcion:         Script encargado de crear la BDD

clear screen
whenever sqlerror exit rollback;

Prompt Iniciando con la creacion de la BDD.
@s-01-autos-main-usuario.sql
@s-02-autos-ligas.sql
@s-03-autos-main-ddl.sql
@s-04-autos-main-sinonimos.sql
@s-05-autos-main-vistas.sql
@s-06-autos-main-triggers.sql
@s-07-autos-main-soporte-blobs.sql

Prompt Listo !
exit