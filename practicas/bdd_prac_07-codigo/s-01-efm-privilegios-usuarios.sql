--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Privilegios de usuario 

prompt Conectandose a efmbd_s1 como usuario SYS
connect sys@efmbd_s1 as sysdba

prompt Otorgando privilegios al usuario EDITORIAL_BDD
grant create synonym, create view, create type, create procedure to editorial_bdd;

prompt Conectandose a efmbd_s2 como usuario SYS
connect sys@efmbd_s2 as sysdba

prompt Otorgando privilegios al usuario EDITORIAL_BDD
grant create synonym, create view, create type, create procedure to editorial_bdd;

prompt Listo!
exit
