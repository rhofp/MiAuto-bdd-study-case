-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/01/2021
-- @Descripcion: Script para la creacion de tablas temporales

Prompt Conectandose a rfpbd_s1 como usuario editorial_bdd
connect editorial_bdd/editorial_bdd@rfpbd_s1 

create global temporary table t_articulo_insert (
  articulo_id number(8,0) constraint t_articulo_insert_pk primary key,
  pdf blob not null
) on commit preserve rows;

create global temporary table t_pago_suscriptor_insert (
  num_pago varchar2(40)       not null, 
  suscriptor_id number(10,0)  not null,
  fecha_pago date             not null,
  importe numeric(8,2)        not null,
  recibo_pago blob not null,
  constraint t_pago_suscriptor_insert_pk primary key (num_pago,suscriptor_id)
) on commit preserve rows;

Prompt Conectandose a rfpbd_s2 como usuario editorial_bdd
connect editorial_bdd/editorial_bdd@rfpbd_s2 

create global temporary table t_pago_suscriptor_insert (
  num_pago varchar2(40)       not null, 
  suscriptor_id number(10,0)  not null,
  fecha_pago date             not null,
  importe numeric(8,2)        not null,
  recibo_pago blob not null,
  constraint t_pago_suscriptor_insert_pk primary key (num_pago,suscriptor_id)
) on commit preserve rows;

Prompt Listo!
exit
