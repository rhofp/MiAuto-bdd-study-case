--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Script encargado de realizar consultas con sinonimos
--                  en ambas PDBs

prompt conectado a efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1
prompt Realizando conteo de registros
set serveroutput on
start s-03-efm-consultas-localizacion.sql

prompt conectado a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2
prompt Realizando conteo de registros
set serveroutput on
start s-03-efm-consultas-localizacion.sql
