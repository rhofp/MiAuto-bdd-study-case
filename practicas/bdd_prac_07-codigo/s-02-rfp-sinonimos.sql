--@Author:          Rodrigo Francisco
--@Fecha creacion:  01/01/2021
--@Descripcion:     Creacion de sinonimos

Prompt Otorgandndose a rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

Prompt creando sinonimos en rfpbd_s1

create or replace synonym pais_1 for f_rfp_pais_1;
create or replace synonym pais_2 for f_rfp_pais_2@rfpbd_s2;

create or replace synonym suscriptor_1 for f_rfp_suscriptor_1;
create or replace synonym suscriptor_2 for f_rfp_suscriptor_2;
create or replace synonym suscriptor_3 for f_rfp_suscriptor_3;
create or replace synonym suscriptor_4 for f_rfp_suscriptor_4@rfpbd_s2;

create or replace synonym revista_1 for f_rfp_revista_1;
create or replace synonym revista_2 for f_rfp_revista_2@rfpbd_s2;

create or replace synonym articulo_1 for f_rfp_articulo_1@rfpbd_s2;
create or replace synonym articulo_2 for f_rfp_articulo_2;

create or replace synonym articulo_revista_1 for f_rfp_articulo_revista_1;
create or replace synonym articulo_revista_2 for f_rfp_articulo_revista_2@rfpbd_s2;

create or replace synonym pago_suscriptor_1 for f_rfp_pago_suscriptor_1;
create or replace synonym pago_suscriptor_2 for f_rfp_pago_suscriptor_2@rfpbd_s2;


Prompt conectandose a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

Prompt creando sinonimos en rfpbd_s2

create or replace synonym pais_1 for f_rfp_pais_1@rfpbd_s1;
create or replace synonym pais_2 for f_rfp_pais_2;

create or replace synonym suscriptor_1 for f_rfp_suscriptor_1@rfpbd_s1;
create or replace synonym suscriptor_2 for f_rfp_suscriptor_2@rfpbd_s1;
create or replace synonym suscriptor_3 for f_rfp_suscriptor_3@rfpbd_s1;
create or replace synonym suscriptor_4 for f_rfp_suscriptor_4;

create or replace synonym revista_1 for f_rfp_revista_1@rfpbd_s1;
create or replace synonym revista_2 for f_rfp_revista_2;

create or replace synonym articulo_1 for f_rfp_articulo_1;
create or replace synonym articulo_2 for f_rfp_articulo_2@rfpbd_s1;

create or replace synonym articulo_revista_1 for f_rfp_articulo_revista_1@rfpbd_s1;
create or replace synonym articulo_revista_2 for f_rfp_articulo_revista_2;

create or replace synonym pago_suscriptor_1 for f_rfp_pago_suscriptor_1@rfpbd_s1;
create or replace synonym pago_suscriptor_2 for f_rfp_pago_suscriptor_2;

Prompt Listo!
exit
