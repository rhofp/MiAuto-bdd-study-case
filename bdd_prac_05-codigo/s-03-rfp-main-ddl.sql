-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 27/10/2010
-- @Descripcion: Archivo main para llamar a script de ddl

prompt Conectando al usuario editorial_bdd del PDB 1
connect editorial_bdd/editorial_bdd@rfpbd_s1
@s-02-rfp-n1-ddl.sql

prompt Conectando al usuario editorial_bdd del PDB 2
connect editorial_bdd/editorial_bdd@rfpbd_s2
@s-02-rfp-n2-ddl.sql

Prompt Listo!
-- TOODO:- Verificar si es necesario salir
exit