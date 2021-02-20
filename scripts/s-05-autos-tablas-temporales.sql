--@Author:              Emanuel Flores Martinez 
--@Fecha de creacion:   20/01/2021
--@Descripcion:         Definicion de tablas temporales para manejo de datos BLOB

-- bloque anonimo para eliminar tablas temporales
Prompt eliminando tablas en caso de existir
declare
  cursor cur_tablas is
    select table_name
    from user_tables
    where table_name in ('TI_AUTO_F3', 'TS_AUTO_F3')
    or table_name in ('TI_PAGO_AUTO_F1', 'TI_PAGO_AUTO_F2', 'TS_PAGO_AUTO_F1',
      'TS_PAGO_AUTO_F2');
begin
  for r in cur_tablas loop
    execute immediate 'drop table ' || r.table_name;
  end loop;
end;
/

-- tablas temporales auto
Prompt tablas temporales para la tabla auto

create global temporary table ti_auto_f3 (
  auto_id number(10,0) constraint ti_auto_f3_pk primary key,
  foto blob not null
) on commit preserve rows;

create global temporary table ts_auto_f3 (
  auto_id number(10,0) constraint ts_auto_f3_pk primary key,
  foto blob not null
) on commit preserve rows;

-- tablas temporales pago_auto
Prompt tablas temporales para la tabla pago_auto_f1

create global temporary table ti_pago_auto_f1 (
  cliente_id number(10,0),
  auto_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint ti_pago_auto_f1_pk primary key (cliente_id, auto_id)
) on commit preserve rows;

create global temporary table ts_pago_auto_f1 (
  cliente_id number(10,0),
  auto_id number(10,0),
  recibo_pago blob not null,
  constraint ts_pago_auto_f1_pk primary key (cliente_id, auto_id)
) on commit preserve rows;

Prompt tablas temporales para la tabla pago_auto_f2

create global temporary table ti_pago_auto_f2 (
  cliente_id number(10,0),
  auto_id number(10,0),
  fecha_pago date not null,
  importe number(8,2) not null,
  recibo_pago blob not null,
  constraint ti_pago_auto_f2_pk primary key (cliente_id, auto_id)
) on commit preserve rows;

create global temporary table ts_pago_auto_f2 (
  cliente_id number(10,0),
  auto_id number(10,0),
  recibo_pago blob not null,
  constraint ts_pago_auto_f2_pk primary key (cliente_id, auto_id)
) on commit preserve rows;