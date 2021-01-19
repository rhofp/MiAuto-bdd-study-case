--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   19/01/2021
--@Descripcion:         Creación de vistas

-- pais (2)
create or replace view pais as
  select pais_id,nombre,clave,region from pais_f1
  union all
  select pais_id,nombre,clave,region from pais_f2;

-- sucursal (3)
create or replace view sucursal as
  select sucursal_id, nombre,clave,pais_id,sucursal_anexa_id
  from sucursal_f1 
  union all
  select sucursal_id, nombre,clave,pais_id,sucursal_anexa_id
  from sucursal_f2
  union all
  select sucursal_id, nombre,clave,pais_id,sucursal_anexa_id
  from sucursal_f3;

-- auto_particular (2)
create or replace view auto_particular as
  select auto_id,num_cilindros,num_pasajeros,clase
  from auto_particular_f1 
  union all
  select auto_id,num_cilindros,num_pasajeros,clase
  from auto_particular_f2;

-- auto_carga (2)
create or replace view auto_carga as
  select auto_id,peso_maximo,volumen,tipo_combustible
  from auto_carga_f1
  union all
  select auto_id,peso_maximo,volumen,tipo_combustible
  from auto_carga_f1;

-- historico_status_auto (2)
create or replace view historico_status_auto as
  select historico_status_id,fecha_status,status_auto_id,auto_id 
  from hist_status_auto_f1
  union all 
  select historico_status_id,fecha_status,status_auto_id,auto_id 
  from hist_status_auto_f2;;

-- cliente (3)
create or replace view cliente as
  select cliente_id,nombre,ap_paterno,ap_materno, num_identificador,email
  from cliente_f1
  union all
  select cliente_id,nombre,ap_paterno,ap_materno, num_identificador,email
  from cliente_f2
  union all
  select cliente_id,nombre,ap_paterno,ap_materno, num_identificador,email
  from cliente_f3;

-- tarjeta_cliente (2)
create or replace tarjeta_cliente as
  select cliente_id,num_tarjeta,num_tarjeta,anio_expira,mes_expira,
  codigo_seguridad,tipo 
  from tarjeta_cliente_f1
  union all 
  select cliente_id,num_tarjeta,num_tarjeta,anio_expira,mes_expira,
  codigo_seguridad,tipo 
  from tarjeta_cliente_f2;
