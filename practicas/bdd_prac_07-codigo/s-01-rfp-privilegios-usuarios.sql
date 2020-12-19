-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/01/2021
-- @Descripcion: Script para la otorgar permisos 

Prompt Conectandose a rfpbd_s1 como usuario sys
connect sys@rfpbd_s1 as sysdba

prompt Otorgando privilegios para crear sinonimos, vistas, procs y tipos a editorial_bdd
grant create synonym, create view, create type, create procedure to editorial_bdd;

Prompt Conectandose a rfpbd_s2 como usuario sys
connect sys@rfpbd_s2 as sysdba

prompt Otorgando privilegios para crear sinonimos, vistas, procs y tipos a editorial_bdd
grant create synonym, create view, create type, create procedure to editorial_bdd;

Prompt Listo!
exit
