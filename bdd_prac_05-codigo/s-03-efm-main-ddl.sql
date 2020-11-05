--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Creción de objetos en cada PDB

prompt Conectandose a efmbd_s1 como usuario EDITORIAL_BDD
connect editorial_bdd/editorial_bdd@efmbd_s1
@s-02-efm-n1-ddl.sql

prompt Conectandose a efmbd_s2 como usuario EDITORIAL_BDD
connect editorial_bdd/editorial_bdd@efmbd_s2
@s-02-efm-n2-ddl.sql

prompt Listo!

exit
