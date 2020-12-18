--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Script de ejecución para crear vistas
--                  en ambas PDBs

Prompt conectandose a efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1

Prompt creando vistas en efmbd_s1
@s-04-efm-def-vistas.sql

Prompt conectandose a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2

Prompt creando vistas en efmbd_s2
@s-04-efm-def-vistas.sql

Prompt Listo!
exit