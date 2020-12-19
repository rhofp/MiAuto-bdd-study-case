--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  17/12/2020
--@Descripción:     Definición de vistas para manejo de BLOBs en la PDB efmbd_s1

Prompt conectando a efmbd_s1
connect editorial_bdd/editorial_bdd@efmbd_s1

prompt ---
prompt Paso 1. creando vistas con columnas BLOB locales.
prompt ---

prompt ---
prompt Paso 2. creando objetos type para vistas que involucran BLOBs remotos
prompt ---

-- Objeto type para ARTICULO
create type articulo_type as object (
  articulo_id number(10,0),
  pdf blob
);
/
show errors;

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

create type articulo_table as table of articulo_type;
/
show errors;

create type pago_suscriptor_table as table of pago_suscriptor_type;
/
show errors;

prompt ---
prompt Paso 4. creando tablas temporales para vistas que involucran BLOBs remotos
prompt ---

create global temporary table t_efm_articulo_1 (
  articulo_id number(10,0) constraint t_efm_articulo_1_pk primary key,
  pdf blob not null
) on commit preserve rows;

create global temporary table t_efm_pago_suscriptor_2 (
  num_pago number(10,0),
  suscriptor_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint t_efm_pago_suscriptor_2_pk
  primary key (num_pago, suscriptor_id)
) on commit preserve rows;

prompt ---
prompt Paso 5. creando funcion con estrategia 1 para vistas que involucran BLOBs remotos
prompt ---

create or replace function get_remote_pdf return articulo_table pipelined is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_articulo_1;

  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_articulo_1 select articulo_id,pdf from articulo_1;
  commit;

  --obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
  for cur in (select articulo_id,pdf from t_efm_articulo_1) 
  loop
    pipe row(articulo_type(cur.articulo_id,cur.pdf));
  end loop;

  --elimina los registros de la tabla temporal una vez que han sido obtenidos.
  delete from t_efm_articulo_1;
  commit;
  return;
exception
  when others then
    rollback;
    raise;
end;
/

create or replace function get_remote_recibo_pago return pago_suscriptor_table pipelined is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_pago_suscriptor_2;
  
  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_pago_suscriptor_2 
  select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago from pago_suscriptor_2;
  commit;

  --obtiene los registros de la tabla temporal y los regresa como objetos tipo pdf_type
  for cur in (
    select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago 
    from t_efm_pago_suscriptor_2) 
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
  delete from t_efm_pago_suscriptor_2;
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

create or replace function get_remote_pdf_by_id(v_articulo_id in number ) return blob is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_articulo_1;
  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_articulo_1 select articulo_id,pdf 
    from articulo_1 where articulo_id = v_articulo_id;
  --obtiene el registro de la tabla temporal y lo regresa como blob
  select pdf into v_temp_pdf 
    from t_efm_articulo_1 
    where articulo_id = v_articulo_id;
  --elimina los registros de la tabla temporal una vez que han sido obtenidos.
  delete from t_efm_articulo_1;
  commit;
  return v_temp_pdf;
exception
  when others then
    rollback;
    raise;
end;
/
show errors;


create or replace function get_remote_recibo_by_id(
  v_num_pago in number, 
  v_suscriptor_id number) 
return blob is
pragma autonomous_transaction;
  v_temp_pdf blob;
begin
  --asegura que no haya registros
  delete from t_efm_pago_suscriptor_2;
  --inserta los datos obtenidos del fragmento remoto a la tabla temporal.
  insert into t_efm_pago_suscriptor_2 
  select num_pago,suscriptor_id,fecha_pago,importe,recibo_pago 
    from pago_suscriptor_2 
    where num_pago = v_num_pago and suscriptor_id = v_suscriptor_id;

  --obtiene el registro de la tabla temporal y lo regresa como blob
  select recibo_pago into v_temp_pdf 
  from t_efm_pago_suscriptor_2 
  where num_pago = v_num_pago and suscriptor_id = v_suscriptor_id;

  --elimina los registros de la tabla temporal una vez que han sido obtenidos.
  delete from t_efm_pago_suscriptor_2;
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

create or replace view articulo_e1 as
  select a1.articulo_id, a2.titulo, a2.resumen, a2.texto, a1.pdf
  from (
    select articulo_id, titulo, resumen, texto
    from articulo_2
  ) a2 join (
    select * from table (get_remote_pdf)
  ) a1 on a1.articulo_id = a2.articulo_id;

create or replace view pago_suscriptor_e1 as
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from pago_suscriptor_1
  union all 
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from table (get_remote_recibo_pago);


prompt ---
prompt Paso 8. crear las vistas con datos BLOB remotos empleando estrategia 2
prompt ---

create or replace view articulo_e2 as
  select articulo_id, titulo, resumen, texto, 
    get_remote_pdf_by_id(articulo_id) as pdf
  from articulo_2;

create or replace view pago_suscriptor_e2 as
  select num_pago, suscriptor_id, fecha_pago, importe, recibo_pago
  from pago_suscriptor_1
  union all
  select num_pago, suscriptor_id, fecha_pago, importe,
    get_remote_recibo_by_id(num_pago, suscriptor_id)
  from pago_suscriptor_2;

prompt ---
prompt Paso 9. crear un sinonimo con el nombre global del fragmento que apunte a la estrategia 2
prompt ---

create or replace synonym articulo for articulo_e2;
create or replace synonym pago_suscriptor for pago_suscriptor_e2;

Prompt Listo!
exit





