--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/20202
--@Descripcion: Consulta de restricciones de referencia en rfp-pc

Prompt mostrando lista de restricciones de referencia 
col tabla_padre format A30
col tabla_hija format A30
col nombre_restriccion format A30
set linesize 200

-- Mostrar
-- Nombre de la tabla hija
-- nombre de la restricciones de referencia
-- Nombre de la tabla padre
-- Tipo de restriccion

select h.table_name tabla_hija, 
h.r_constraint_name nombre_restriccion,
p.table_name tabla_padre
from user_constraints h
join user_constraints p
on h.r_constraint_name = p.constraint_name
where h.constraint_type = 'R' 
and h.r_constraint_name is not null;