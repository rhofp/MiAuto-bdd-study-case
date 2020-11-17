--@Author:	    Emanuel Flores Martinez
--@Fecha creacion:  05/11/2020
--@Descripcion:     Consulta de fragmentos creados en pc-efm

prompt Conectando a S1 - efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1
@s-05-efm-consulta-restricciones.sql

prompt Conectando a S2 - efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2
@s-05-efm-consulta-restricciones.sql

prompt Listo!
exit
