--@Autor:          Rodrigo Francisco
--@Fecha creación: 01/01/2021
--@Descripción:    Definición de vistas para manejo de BLOBs en la PDB rfpbd_s2

Prompt connectando a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

prompt ---
Prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---

-- Vista articulo 
-- La columna blob se encuentra en el nodo 2, por lo tanto se puede realizar
-- la vista
create or replace view articulo as
select q1.articulo_id, q1.titulo, q1.resumen, q1.texto, q1.pdf 
from (
  select a1.articulo_id, titulo, resumen, texto, pdf  
  from  f_rfp_articulo_2@rfpbd_s1.fi.unam a2
  join f_rfp_articulo_1 a1
  on a2.articulo_id = a1.articulo_id 
) q1;

prompt ---
Prompt Paso 2 creando objetos type para vistas que involucran BLOBs remotos
prompt ---

-- Type para construir la tabla PAGO_SUSCRIPTOR
create type recibo_type as object (                                                
    num_pago varchar2(40),       -- Se definio como varchar en el ddl por error
    suscriptor_id number(10,0), 
    fecha_pago date,
    importe number(8,2),
    recibo_pago blob
);                                                                              
/                                                                               
show errors;

prompt ---
Prompt Paso 3 creando objetos table para vistas que involucran BLOBs remotos
prompt ---

create or replace type recibo_table as table of recibo_type;                          
/                                                                               
show errors;

prompt ---
Prompt Paso 4 creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---

create global temporary table t_pago_suscriptor_1(                               
  num_pago varchar2(40) not null,
  suscriptor_id number(10,0) not null,        
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint t_pago_suscriptor_1_pk primary key(suscriptor_id, num_pago)
) on commit preserve rows; 

prompt ---
Prompt Paso 5 Creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---

create or replace function get_remote_recibo return recibo_table pipelined is
  pragma autonomous_transaction;
  v_temp_recibo blob;
  begin
    -- Asegura que no haya registros
    delete from t_pago_suscriptor_1;
    -- Inserta los datos obtenidos del fragmento remoto a la tabla temporal.
    insert into t_pago_suscriptor_1 select num_pago, suscriptor_id,
    fecha_pago, importe, recibo_pago from pago_suscriptor_1;
    commit;
    -- Obtener registros de la tabla temporal y los regresa como objetos tipo
    -- recibo_type 
    for cur in (select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago
    from t_pago_suscriptor_1)
    loop
      pipe row(recibo_type(cur.num_pago,cur.suscriptor_id,cur.fecha_pago,
          cur.importe,cur.recibo_pago));
    end loop;
    -- Elimina los registros de la tabla temporal una vez que ha sido obtenidos
    delete from t_pago_suscriptor_1;
    commit;
    return;
  exception
    when others then
      rollback;
      raise;
  end;
  /
show errors

prompt ---
Prompt Paso 6 Creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
prompt ---

create or replace function get_remote_recibo_by_id(v_num_pago in varchar2, 
  v_suscriptor_id in number) return blob is
  pragma autonomous_transaction;
  v_temp_recibo blob;
  begin
    --dbms_output.put_line('Invocando fx '||v_num_pago||' y '||v_suscriptor_id);
    -- Asegura que no haya registros
    delete from t_pago_suscriptor_1;
    -- Inserta los datos del fragmento remeto a la tabla temporal
    insert into t_pago_suscriptor_1 select num_pago, suscriptor_id,
    fecha_pago, importe, recibo_pago from pago_suscriptor_1
    where num_pago = v_num_pago and 
    suscriptor_id = v_suscriptor_id;
    -- Obtiene el registro de la tabla temporal y lo regresa como blob
    select recibo_pago into v_temp_recibo from t_pago_suscriptor_1 
    where num_pago = v_num_pago and 
    suscriptor_id = v_suscriptor_id;
    -- Elimina los registros de la tabla temporal una vez que han sido obtenidos
    delete from t_pago_suscriptor_1;
    commit;
    return v_temp_recibo;
  exception
  when others then
    rollback;
    raise;
  end;
  /

prompt ---
Prompt Paso 7 Crear las vistas con datos BLOB remotos empleando estrategia 1
prompt ---

create or replace view pago_suscriptor_e1 as
  select num_pago, suscriptor_id,fecha_pago, importe, recibo_pago
  from table (get_remote_recibo)
  union all
  select num_pago, suscriptor_id,fecha_pago, importe, recibo_pago
  from pago_suscriptor_2;

prompt ---
Prompt Paso 8 Crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---

create or replace view pago_suscriptor_e2 as
  select num_pago, suscriptor_id,fecha_pago, importe, recibo_pago
  from pago_suscriptor_2
  union all
  select num_pago, suscriptor_id,fecha_pago, importe, 
  get_remote_recibo_by_id(num_pago,suscriptor_id) 
  from pago_suscriptor_1;

prompt ---
Prompt Paso 9 Crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2.
prompt ---

create or replace synonym pago_suscriptor for pago_suscriptor_e2;

Prompt Listo!
exit
