--@Autor: Francisco Pablo Rodrigo
--@Fecha creacion: 03 de noviembre de 2020
--@Descripcion: Creacion de tablas para el fragmento n2

prompt Creando tablas para el fragmento N1

declare
  v_count number;
  v_revista2 varchar2(30) := 'F_RFP_REVISTA_2';
  v_articulo_revista2 varchar2(30) := 'F_RFP_ARTICULO_REVISTA_2';
  v_suscriptor4 varchar2(30) := 'F_RFP_SUSCRIPTOR_4';
  v_articulo1 varchar2(30) := 'F_RFP_ARTICULO_1';
  v_pago_suscriptor2 varchar2(30) := 'F_RFP_PAGO_SUSCRIPTOR_2';
  v_pais2 varchar2(30) := 'F_RFP_PAIS_2';
begin
  -- Comprobando la existencia de revista2
  select count(*) into v_count
  from all_tables
  where table_name = v_revista2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_revista2;
  end if;

  -- Comprobando la existencia de articulo_revista2
  select count(*) into v_count
  from all_tables
  where table_name = v_articulo_revista2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_articulo_revista2;
  end if;

  -- Comprobando la existencia de suscriptor4
  select count(*) into v_count
  from all_tables
  where table_name = v_suscriptor4;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_suscriptor4;
  end if;

  -- Comprobando la existencia de articulo1
  select count(*) into v_count
  from all_tables
  where table_name = v_articulo1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_articulo1;
  end if;

  -- Comprobando la existencia de pago_suscriptor2
  select count(*) into v_count
  from all_tables
  where table_name = v_pago_suscriptor2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_pago_suscriptor2;
  end if;  

  -- Comprobando la existencia de pais2
  select count(*) into v_count
  from all_tables
  where table_name = v_pais2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_pais2;
  end if;  

end;
/

-- 
-- table: f_rfp_articulo_1 
--

create table f_rfp_articulo_1(
    articulo_id    number(10, 0)    not null,
    pdf            blob             not null,
    constraint f_rfp_articulo_1_pk primary key (articulo_id)
);

-- 
-- table: f_rfp_revista_2 
--

create table f_rfp_revista_2(
    revista_id             number(10, 0)    not null,
    folio                  varchar2(10)     not null,
    revista_adiciona_id    number(10, 0),
    titulo                 varchar2(40)     not null,
    fecha_publicacion      date             not null,
    constraint f_rfp_revista_2_pk primary key (revista_id)
);

-- 
-- table: f_rfp_articulo_revista_2 
--

create table f_rfp_articulo_revista_2(
    articulo_revista_id    number(10, 0)    not null,
    fecha_aprobacion       date             not null,
    calificacion           number(3, 1)     not null,
    revista_id             number(10, 0)    not null,
    articulo_id            number(10, 0)    not null,
    constraint f_rfp_articulo_revista_2_pk primary key (articulo_revista_id), 
    constraint articulo_revista_revista_id_fk foreign key (revista_id)
    references f_rfp_revista_2(revista_id),
    constraint articulo_revista_articulo_id_fk foreign key (articulo_id)
    references f_rfp_articulo_1(articulo_id)
);

-- 
-- table: f_rfp_pago_suscriptor_2 
--

create table f_rfp_pago_suscriptor_2(
    num_pago         varchar2(40)     not null,
    suscriptor_id    number(10, 0)    not null,
    fecha_pago       date             not null,
    importe          number(8, 2)     not null,
    recibo_pago      blob             not null,
    constraint f_rfp_pago_suscriptor_2_pk primary key (num_pago, suscriptor_id)
);

-- 
-- table: f_rfp_pais_2 
--

create table f_rfp_pais_2(
    pais_id             number(10, 0)    not null,
    clave               varchar2(3)      not null,
    nombre              varchar2(40)     not null,
    region_economica    char(1)          not null,
    constraint f_rfp_pais_2_pk primary key (pais_id)
);

-- 
-- table: f_rfp_suscriptor_4 
--

create table f_rfp_suscriptor_4(
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40)     not null,
    fecha_inscripcion    varchar2(40)     not null,
    pais_id              number(10, 0)    not null,
    constraint f_rfp_suscriptor_4_pk primary key (suscriptor_id), 
    constraint f_rfp_suscriptor_4_pais_id_fk foreign key (pais_id)
    references f_rfp_pais_2(pais_id)
);
