-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion: Script para crear ligas

prompt Creando liga en rfpbd_s1 hacia rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s1 
create database link rfpbd_s2.fi.unam using 'RFPBD_S2';

prompt Creando liga en rfpbd_s2 hacia rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s2 
create database link rfpbd_s1.fi.unam using 'RFPBD_S1';

Prompt Listo!
exit
