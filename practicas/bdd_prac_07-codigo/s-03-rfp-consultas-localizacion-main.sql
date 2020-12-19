--@Author:          Rodrigo Francisco
--@Fecha creacion:  01/01/2021
--@Descripcion:     Script encargado de realizar consultas con sinonimos
--                  en ambas PDBs

prompt conectando a rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

prompt Realizando conteo de registros
set serveroutput on
start s-03-rfp-consultas-localizacion.sql

prompt conectando a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

prompt Realizando conteo de registros
set serveroutput on
start s-03-rfp-consultas-localizacion.sql

