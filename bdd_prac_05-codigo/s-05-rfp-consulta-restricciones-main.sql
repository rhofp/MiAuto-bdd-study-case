--@Autor: Rodrigo Francisco Pablo
--@Fecha creacion: 03/11/20202
--@Descripcion: Consulta de restricciones de referencia en rfp-pc

Prompt Conectando a S1 - rfpbd_s1
connect bancos_bdd/editorial_bdd@rfpbd_s1
--ejecuta la misma consulta en ambas pdbs
@s-05-rfp-consulta-restricciones.sql

Prompt Conectando a S2 - rfpbd_s2
connect bancos_bdd/editorial_bdd@rfpbd_s2
--ejecuta la misma consulta en ambas pdbs
@s-05-rfp-consulta-restricciones.sql

Prompt Listo!
exit