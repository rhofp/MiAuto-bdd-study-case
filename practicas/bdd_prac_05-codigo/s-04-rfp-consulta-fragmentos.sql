--@Autor:Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/2020
--@Descripcion: Consulta de fragmentos creados en rfp-pc

Prompt Conectando a S1 - rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1
Prompt mostrando lista de fragmentos

select table_name 
from all_tables
where table_name like 'F_RFP%'
order by table_name;

Prompt Conectando a S1 - rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2
Prompt mostrando lista de fragmentos

select table_name 
from all_tables
where table_name like 'F_RFP%'
order by table_name;

Prompt Listo!
exit