--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  17/12/2020
--@Descripción:     Definición de vistas para manejo de BLOBs en la PDB efmbd_s2

Prompt conectando a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2

prompt ---
prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---

-- View para ARTICULO
create or replace view articulo as
  select a1.articulo_id, a2.titulo, a2.resumen, a2.texto, a1.pdf
  from articulo_1 a1
  join articulo_2 a2
  on a1.articulo_id = a2.articulo_id;

prompt ---
prompt Paso 2. creando objetos type para vistas que involucran BLOBs remotos
prompt ---

-- Objeto type para PAGO_SUSCRIPTOR (recibo_pago)
create type pago_suscriptor_type as object (
  num_pago number(10,0),
  suscriptor_id number(10,0),
  fecha_pago date,
  importe number(8,2),
  recibo_pago blob
);
/
show errors;

prompt ---
prompt Paso 3. creando objetos table para vistas que involucran BLOBs remotos
prompt ---

create type pago_suscriptor_table as table of pago_suscriptor_type;
/
show errors;

prompt ---
prompt Paso 4. creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---

create global temporary table t_efm_pago_suscriptor_1 (
  num_pago number(10,0),
  suscriptor_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint t_efm_pago_suscriptor_1 
  primary key (num_pago, suscriptor_id)
) on commit preserve rows;

prompt ---
prompt Paso 5. creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---

create or replace function get_remote_recibo_pago return pago_suscriptor_table pipelined is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_pago_suscriptor_1;
  
  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_pago_suscriptor_1 
  select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago from pago_suscriptor_1;
  commit;

  --obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
  for cur in (
    select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago 
    from t_efm_pago_suscriptor_1) 
  loop
    pipe row(pago_suscriptor_type(
      cur.num_pago,
      cur.suscriptor_id,
      cur.fecha_pago,
      cur.importe,
      cur.recibo_pago
    ));
  end loop;

  --elimina los registros de la tabla temporal una vez que han sido obtenidos.
  delete from t_efm_pago_suscriptor_1;
  commit;
  return;
exception
  when others then
    rollback;
    raise;
end;
/

prompt ---
prompt Paso 6. creando funcion con estrategia 2 para vistas que involucran BLOBs remotos
prompt ---

create or replace function get_remote_recibo_by_id(
  v_num_pago in number, 
  v_suscriptor_id number) 
return blob is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_pago_suscriptor_1;
  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_pago_suscriptor_1 
  select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago 
    from pago_suscriptor_1
    where num_pago = v_num_pago and suscriptor_id = v_suscriptor_id;

  --obtiene el registro de la tabla temporal y lo regresa como blob
  select recibo_pago into v_temp_pdf 
  from t_efm_pago_suscriptor_1 
  where num_pago = v_num_pago and suscriptor_id = v_suscriptor_id;
  
  --elimina los registros de la tabla temporal una vez que han sido obtenidos.
  delete from t_efm_pago_suscriptor_1;
  commit;
  return v_temp_pdf;
exception
  when others then
    rollback;
    raise;
end;
/
show errors;

prompt ---
prompt Paso 7. crear las vistas con datos BLOB remotos empleando estrategia 1
prompt ---

create or replace view pago_suscriptor_e1 as
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from pago_suscriptor_2
  union all 
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from table (get_remote_recibo_pago);

prompt ---
prompt Paso 8. crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---

create or replace view pago_suscriptor_e2 as
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from pago_suscriptor_2
  union all
  select num_pago, suscriptor_id, fecha_pago, importe,
    get_remote_recibo_by_id(num_pago, suscriptor_id)
  from pago_suscriptor_1;

prompt ---
prompt Paso 9. crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2
prompt ---

create or replace synonym pago_suscriptor for pago_suscriptor_e2;

Prompt Listo!
exit

