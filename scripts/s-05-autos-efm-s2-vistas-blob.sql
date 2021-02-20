--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   20/01/2021
--@Descripcion:         Creacion de vistas que requieren manejo de datos BLOB
--                      para el sitio efmbd_s2

Prompt creando vistas que requieren acceso remoto

-- auto
create or replace view auto as
  select q1.auto_id, q1.foto, q2.anio, q2.num_serie, q2.tipo, q2.precio, 
    q2.fecha_status, q2.sucursal_id, q2.status_auto_id, q2.modelo_id
  from auto_f3 q1
  join (
    select auto_id, anio, num_serie, tipo, precio, fecha_status,
      sucursal_id, status_auto_id, modelo_id
    from auto_f1 
    union all
    select auto_id, anio, num_serie, tipo, precio, fecha_status,
      sucursal_id, status_auto_id, modelo_id
    from auto_f2
  ) q2
  on q1.auto_id = q2.auto_id;

-- pago_auto
create or replace view pago_auto as
  select cliente_id, auto_id, fecha_pago, importe,
    get_remote_r_pago_f1_by_id(cliente_id, auto_id) as recibo_pago
  from pago_auto_f1
  union all 
  select cliente_id, auto_id, fecha_pago, importe,
    get_remote_r_pago_f2_by_id(cliente_id, auto_id) as recibo_pago
  from pago_auto_f2;