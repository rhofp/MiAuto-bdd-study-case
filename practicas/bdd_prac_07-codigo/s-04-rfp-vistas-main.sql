--@Autor:           Rodrigo Francisco
--@Fecha creación:  01/01/2021
--@Descripción:     Script de ejecución para crear de vistas
--                  en ambas PDBs

Prompt conectandose a rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

Prompt creando vistas en rfpbd_s1
@s-04-rfp-def-vistas.sql

Prompt conectandose a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

Prompt creando vistas en rfpbd_s2
@s-04-rfp-def-vistas.sql

Prompt Listo!
exit
