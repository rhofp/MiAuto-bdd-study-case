--@Author:	    Emanuel Flores Martinez
--@Fecha creacion:  14/01/2021
--@Descripcion:     Privilegios de usuario 

prompt Conectandose a efmbd_s1 como usuario SYS
connect sys@efmbd_s1 as sysdba

prompt Otorgando privilegios al usuario EDITORIAL_BDD
grant create trigger to editorial_bdd;

prompt Conectandose a efmbd_s2 como usuario SYS
connect sys@efmbd_s2 as sysdba

prompt Otorgando privilegios al usuario EDITORIAL_BDD
grant create trigger to editorial_bdd;

prompt Listo!
exit
