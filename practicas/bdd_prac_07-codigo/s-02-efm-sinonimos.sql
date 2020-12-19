--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Creación de sinonimos

Prompt conectandose a efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1;

Prompt creando sinónimos en efmbd_s1

-- sinónimos de país en s1
create or replace synonym pais_1 for f_efm_pais_1;
create or replace synonym pais_2 for f_efm_pais_2@efmbd_s2;

-- sinónimos de suscriptor en s1
create or replace synonym suscriptor_1 for f_efm_suscriptor_1;
create or replace synonym suscriptor_2 for f_efm_suscriptor_2;
create or replace synonym suscriptor_3 for f_efm_suscriptor_3;
create or replace synonym suscriptor_4 for f_efm_suscriptor_4@efmbd_s2;

-- sinónimos de artículo en s1
create or replace synonym articulo_1 for f_efm_articulo_1@efmbd_s2;
create or replace synonym articulo_2 for f_efm_articulo_2;

-- sinónimos de revista en s1
create or replace synonym revista_1 for f_efm_revista_1;
create or replace synonym revista_2 for f_efm_revista_2@efmbd_s2;

-- sinónimos para articulo_revista en s1
create or replace synonym articulo_revista_1 for f_efm_articulo_revista_1;
create or replace synonym articulo_revista_2 for f_efm_articulo_revista_2@efmbd_s2;

-- sinónimos para pago suscriptor en s1
create or replace synonym pago_suscriptor_1 for f_efm_pago_suscriptor_1;
create or replace synonym pago_suscriptor_2 for f_efm_pago_suscriptor_2@efmbd_s2;


Prompt conectandose a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2;

Prompt creando sinónimos en efmbd_s2

-- sinónimos de país en s2
create or replace synonym pais_1 for f_efm_pais_1@efmbd_s1;
create or replace synonym pais_2 for f_efm_pais_2;

-- sinónimos de suscriptor en s2
create or replace synonym suscriptor_1 for f_efm_suscriptor_1@efmbd_s1;
create or replace synonym suscriptor_2 for f_efm_suscriptor_2@efmbd_s1;
create or replace synonym suscriptor_3 for f_efm_suscriptor_3@efmbd_s1;
create or replace synonym suscriptor_4 for f_efm_suscriptor_4;

-- sinónimos de artículo en s2
create or replace synonym articulo_1 for f_efm_articulo_1;
create or replace synonym articulo_2 for f_efm_articulo_2@efmbd_s1;

-- sinónimos de revista en s2
create or replace synonym revista_1 for f_efm_revista_1@efmbd_s1;
create or replace synonym revista_2 for f_efm_revista_2;

-- sinónimos para articulo_revista en s2
create or replace synonym articulo_revista_1 for f_efm_articulo_revista_1@efmbd_s1;
create or replace synonym articulo_revista_2 for f_efm_articulo_revista_2;

-- sinónimos para pago suscriptor en s2
create or replace synonym pago_suscriptor_1 for f_efm_pago_suscriptor_1@efmbd_s1;
create or replace synonym pago_suscriptor_2 for f_efm_pago_suscriptor_2;

Prompt Listo!
exit
