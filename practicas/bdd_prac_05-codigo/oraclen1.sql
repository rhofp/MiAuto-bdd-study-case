--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      fi.unam
-- Project :      bdd_prac_04-n1.DM1
-- Author :       windows
--
-- Date Created : Tuesday, November 03, 2020 17:44:12
-- Target DBMS : Oracle 11g
--

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
)
;



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
)
;



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
)
;



-- 
-- table: f_rfp_suscriptor_1 
--

create table f_rfp_suscriptor_1(
    suscriptor_id    number(10, 0)    not null,
    num_tarjeta      varchar2(16)     not null,
    constraint f_rfp_suscriptor_1_pk primary key (suscriptor_id)
)
;



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
)
;



-- 
-- table: f_rfp_pais_1 
--

create table f_rfp_pais_1(
    pais_id             number(10, 0)    not null,
    clave               varchar2(3)      not null,
    nombre              varchar2(40)     not null,
    region_economica    char(1)          not null,
    constraint f_rfp_pais_1_pk primary key (pais_id)
)
;



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
)
;



-- 
-- table: f_rfp_suscriptor_3 
--

create table f_rfp_suscriptor_3(
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40)     not null,
    fecha_inscripcion    varchar2(40)     not null,
    constraint f_rfp_suscriptor_3_pk primary key (suscriptor_id)
)
;



