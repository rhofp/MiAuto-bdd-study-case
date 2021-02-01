--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   18/01/2021
--@Descripcion:         Creacion de sinonimos en rfpbd_s2

-- Pais (2)
create or replace synonym pais_f1 for pais_f1_rfp_s1@rfpbd_s1;
create or replace synonym pais_f2 for pais_f2_rfp_s2;

-- Sucursal (3)
create or replace synonym sucursal_f1 for sucursal_f1_rfp_s1@rfpbd_s1;
create or replace synonym sucursal_f2 for sucursal_f2_rfp_s2;
create or replace synonym sucursal_f3 for sucursal_f3_efm_s1@efmbd_s1;

-- Auto (3)
create or replace synonym auto_f1 for auto_f1_rfp_s1@rfpbd_s1;
create or replace synonym auto_f2 for auto_f2_rfp_s2;
create or replace synonym auto_f3 for auto_f3_efm_s2@efmbd_s2;

-- Auto Particular (2)
create or replace synonym auto_particular_f1 for auto_particular_f1_rfp_s1@rfpbd_s1;
create or replace synonym auto_particular_f2 for auto_particular_f2_rfp_s2;

-- Auto Carga (2)
create or replace synonym auto_carga_f1 for auto_carga_f1_rfp_s1@rfpbd_s1;
create or replace synonym auto_carga_f2 for auto_carga_f2_rfp_s2;

-- Historico Status Auto (2)
create or replace synonym historico_status_auto_f1 for historico_status_auto_f1_efm_s1@efmbd_s1;
create or replace synonym historico_status_auto_f2 for historico_status_auto_f2_efm_s2@efmbd_s2;

-- Cliente (3)
create or replace synonym cliente_f1 for cliente_f1_rfp_s2@rfpbd_s2;
create or replace synonym cliente_f2 for cliente_f2_efm_s1@efmbd_s1;
create or replace synonym cliente_f3 for cliente_f3_efm_s2@efmbd_s2;

-- Pago Auto (2)
create or replace synonym pago_auto_f1 for pago_auto_f1_rfp_s1@rfpbd_s1;
create or replace synonym pago_auto_f2 for pago_auto_f2_rfp_s2;

-- Tarjeta Cliente (2)
create or replace synonym tarjeta_cliente_f1 for tarjeta_cliente_f1_rfp_s2@rfpbd_s2;
create or replace synonym tarjeta_cliente_f2 for tarjeta_cliente_f2_efm_s1@efmbd_s1;

-- Marca (4)
create or replace synonym marca_r1 for marca_r_rfp_s2;
create or replace synonym marca_r2 for marca_r_rfp_s1@rfpbd_s1;
create or replace synonym marca_r3 for marca_r_efm_s1@efmbd_s1;
create or replace synonym marca_r4 for marca_r_efm_s2@efmbd_s2;

-- Modelo (4)
create or replace synonym modelo_r1 for modelo_r_rfp_s2;
create or replace synonym modelo_r2 for modelo_r_rfp_s1@rfpbd_s1;
create or replace synonym modelo_r3 for modelo_r_efm_s1@efmbd_s1;
create or replace synonym modelo_r4 for modelo_r_efm_s2@efmbd_s2;
