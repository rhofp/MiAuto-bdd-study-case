--@Autor: Francisco Pablo Rodrigo
--@Fecha creacion: 03 de noviembre de 2020
--@Descripcion: Creacion de tablas para el fragmento n1

prompt Creando tablas para el fragmento N1

declare
  v_count number;
  v_revista1 varchar2(30) := 'F_RFP_REVISTA_1';
  v_articulo_revista1 varchar2(30) := 'F_RFP_ARTICULO_REVISTA_1';
  v_suscriptor1 varchar2(30) := 'F_RFP_SUSCRIPTOR_1';
  v_suscriptor2 varchar2(30) := 'F_RFP_SUSCRIPTOR_2';
  v_suscriptor4 varchar2(30) := 'F_RFP_SUSCRIPTOR_3';
  v_articulo2 varchar2(30) := 'F_RFP_ARTICULO_2';
  v_pago_suscriptor1 varchar2(30) := 'F_RFP_PAGO_SUSCRIPTOR_1';
  v_pais1 varchar2(30) := 'F_RFP_PAIS_1';
begin
  -- Comprobando la existencia de revista1
  select count(*) into v_count
  from all_tables
  where table_name = v_revista1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_revista1;
  end if;

  -- Comprobando la existencia de articulo_revista1
  select count(*) into v_count
  from all_tables
  where table_name = v_articulo_revista1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_articulo_revista1;
  end if;

  -- Comprobando la existencia de suscriptor1
  select count(*) into v_count
  from all_tables
  where table_name = v_suscriptor1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_suscriptor1;
  end if;

  -- Comprobando la existencia de suscriptor2
  select count(*) into v_count
  from all_tables
  where table_name = v_suscriptor2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_suscriptor2;
  end if;

  -- Comprobando la existencia de suscriptor3
  select count(*) into v_count
  from all_tables
  where table_name = v_suscriptor3;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_suscriptor3;
  end if;

  -- Comprobando la existencia de articulo2
  select count(*) into v_count
  from all_tables
  where table_name = v_articulo2;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_articulo2;
  end if;

  -- Comprobando la existencia de pago_suscriptior1
  select count(*) into v_count
  from all_tables
  where table_name = v_pago_suscriptor1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_pago_suscriptor1;
  end if;  

  -- Comprobando la existencia de pais1
  select count(*) into v_count
  from all_tables
  where table_name = v_pais1;

  -- Eliminando en caso de existir
  if v_count > 0 then
    execute immediate 'drop table '||v_pais1;
  end if;  

end;
/

-- 
-- table: f_rfp_articulo_2 
--

create table f_rfp_articulo_2(
    articulo_id    number(10, 0)     not null,
    titulo         varchar2(40)      not null,
    resumen        varchar2(500)     not null,
    texto          varchar2(4000)    not null,
    pdf            blob              not null,
    constraint f_rfp_articulo_2_pk primary key (articulo_id)
);

-- 
-- table: f_rfp_revista_1 
--

create table f_rfp_revista_1(
    revista_id              number(10, 0)    not null,
    folio                   varchar2(10)     not null,
    revista_adicional_id    number(10, 0),
    titulo                  varchar2(40)     not null,
    fecha_publicacion       date             not null,
    constraint f_rfp_revista_1_pk primary key (revista_id)
);

-- 
-- table: f_rfp_articulo_revista_1 
--

create table f_rfp_articulo_revista_1(
    articulo_revista_id    number(10, 0)    not null,
    fecha_aprobacion       date             not null,
    calificacion           number(3, 1)     not null,
    revista_id             number(10, 0)    not null,
    articulo_id            number(10, 0)    not null,
    constraint f_rfp_articulo_revista_1_pk primary key (articulo_revista_id), 
    constraint articulo_revista_revista_id_fk foreign key (revista_id)
    references f_rfp_revista_1(revista_id),
    constraint articulo_revista_articulo_id_fk foreign key (articulo_id)
    references f_rfp_articulo_2(articulo_id)
);

-- 
-- table: f_rfp_suscriptor_1 
--

create table f_rfp_suscriptor_1(
    suscriptor_id    number(10, 0)    not null,
    num_tarjeta      varchar2(16)     not null,
    constraint f_rfp_suscriptor_1_pk primary key (suscriptor_id)
);

-- 
-- table: f_rfp_pago_suscriptor 
--

create table f_rfp_pago_suscriptor_1(
    num_pago         varchar2(40)     not null,
    suscriptor_id    number(10, 0)    not null,
    fecha_pago       date             not null,
    importe          number(8, 2)     not null,
    recibo_pago      blob             not null,
    constraint f_rfp_pago_suscriptor_pk primary key (num_pago, suscriptor_id), 
    constraint pago_suscriptor_suscriptor_id_fk foreign key (suscriptor_id)
    references f_rfp_suscriptor_1(suscriptor_id)
);

-- 
-- table: f_rfp_pais_1 
--

create table f_rfp_pais_1(
    pais_id             number(10, 0)    not null,
    clave               varchar2(3)      not null,
    nombre              varchar2(40)     not null,
    region_economica    char(1)          not null,
    constraint f_rfp_pais_1_pk primary key (pais_id)
);

-- 
-- table: f_rfp_suscriptor_2 
--

create table f_rfp_suscriptor_2(
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40)     not null,
    fecha_inscripcion    varchar2(40)     not null,
    pais_id              number(10, 0)    not null,
    constraint f_rfp_suscriptor_2_pk primary key (suscriptor_id), 
    constraint suscriptor_pais_id_fk foreign key (pais_id)
    references f_rfp_pais_1(pais_id)
);

-- 
-- table: f_rfp_suscriptor_3 
--

create table f_rfp_suscriptor_3(
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40)     not null,
    fecha_inscripcion    varchar2(40)     not null,
    pais_id              number(10, 0)    not null,
    constraint f_rfp_suscriptor_3_pk primary key (suscriptor_id)
);