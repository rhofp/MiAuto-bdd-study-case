-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion: Script para la otorgar permisos 

Prompt Conectandose a rfpbd_s1 como usuario sys
connect sys@rfpbd_s1 as sysdba

prompt Otorgando privilegios para crear ligar y procedimientos a editorial_bdd
grant create database link, create procedure to editorial_bdd;

Prompt Conectandose a rfpbd_s2 como usuario sys
connect sys@rfpbd_s2 as sysdba

prompt Otorgando privilegios para crear ligar y procedimientos a editorial_bdd
grant create database link, create procedure to editorial_bdd;

Prompt Listo!
exit
