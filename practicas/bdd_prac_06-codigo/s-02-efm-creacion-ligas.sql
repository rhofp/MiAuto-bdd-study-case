--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/12/2020
--@Descripción:     Creación de ligas entre PDBs

prompt Creando liga en efmbd_s1 hacia efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s1
create database link efmbd_s2.fi.unam using 'EFMBD_S2';

prompt Creando liga en efmbd_s2 hacia efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s2
create database link efmbd_s1.fi.unam using 'EFMBD_S1';

prompt Listo!
exit
