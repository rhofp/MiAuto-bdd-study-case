--@Author:	        Emanuel Flores Martinez
--@Fecha creacion:  05/11/2020
--@Descripcion:     Consulta de fragmentos creados en pc-efm

prompt Mostrando lista de restricciones de referencia 
col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A40
set linesize 200

select h.table_name as tabla_hija, 
  h.constraint_name as nombre_restriccion,
  p.table_name as tabla_padre,
  h.constraint_type
from user_constraints h
join user_constraints p
on h.r_constraint_name = p.constraint_name
where h.constraint_type = 'R';

