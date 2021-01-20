--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   20/01/2021
--@Descripcion:         Creacion de vistas que requieren manejo de datos BLOB
--                      para el sitio rfpbd_s1

Prompt creando vistas que requieren acceso remoto

-- auto
create or replace view auto as
  select q1.auto_id, get_remote_foto_f3_by_id(q1.auto_id) as foto,
    q1.anio, q1.num_serie, q1.tipo, q1.precio, q1.fecha_status,
    q1.sucursal_id, q1.status_auto_id, q1.modelo_id
  from (
    select auto_id, anio, num_serie, tipo, precio, fecha_status,
      sucursal_id, status_auto_id, modelo_id
    from auto_f1 
    union all
    select auto_id, anio, num_serie, tipo, precio, fecha_status,
      sucursal_id, status_auto_id, modelo_id
    from auto_f2
  ) q1;

-- pago_auto
create or replace view pago_auto as 
  select cliente_id, auto_id, fecha_pago, importe, recibo_pago
  from pago_auto_f1
  union all
  select cliente_id, auto_id, fecha_pago, importe,
    get_remote_r_pago_f2_by_id(cliente_id, auto_id) as recibo_pago
  from pago_auto_f2;