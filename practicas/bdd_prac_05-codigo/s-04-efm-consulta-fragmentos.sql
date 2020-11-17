--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Consulta de fragmentos creados en pc-efm

prompt Conectando a S1 - efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1
prompt Mostrando lista de fragmentos

select table_name
from user_tables
where table_name like 'F_EFM%';

prompt Conectando a S1 - efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2
prompt Mostrando lista de fragmentos

select table_name
from user_tables
where table_name like 'F_EFM%';

prompt Listo!
exit





