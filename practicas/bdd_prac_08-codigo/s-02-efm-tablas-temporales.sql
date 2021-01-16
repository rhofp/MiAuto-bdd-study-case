--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  14/01/2021
--@Descripción:     Creación de tablas temporales

prompt Conectandose a efmbd_s1 como usuario editorial_bdd
connect editorial_bdd/editorial_bdd@efmbd_s1

prompt Creando tablas temporales

create global temporary table t_articulo_insert (
  articulo_id number(10,0) constraint t_articulo_insert primary key,
  pdf blob not null
) on commit preserve rows;

create global temporary table t_pago_suscriptor_insert (
  num_pago number(10,0),
  suscriptor_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint t_pago_suscriptor_insert_pk
  primary key (num_pago, suscriptor_id)
) on commit preserve rows;

prompt Conectandose a efmbd_s1 como usuario editorial_bdd
connect editorial_bdd/editorial_bdd@efmbd_s2

prompt Creando tablas temporales

create global temporary table t_pago_suscriptor_insert (
  num_pago number(10,0),
  suscriptor_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint t_pago_suscriptor_insert_pk 
  primary key (num_pago, suscriptor_id)
) on commit preserve rows;

prompt Listo!
exit