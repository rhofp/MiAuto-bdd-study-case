--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      fi.unam
-- Project :      bdd_prac_04-n2.DM1
-- Author :       windows
--
-- Date Created : Tuesday, November 03, 2020 17:42:46
-- Target DBMS : Oracle 11g
--

-- 
-- table: f_rfp_articulo_1 
--

create table f_rfp_articulo_1(
    articulo_id    number(10, 0)    not null,
    pdf            blob             not null,
    constraint f_rfp_articulo_1_pk primary key (articulo_id)
)
;



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
)
;



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
)
;



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
)
;



-- 
-- table: f_rfp_pais_2 
--

create table f_rfp_pais_2(
    pais_id             number(10, 0)    not null,
    clave               varchar2(3)      not null,
    nombre              varchar2(40)     not null,
    region_economica    char(1)          not null,
    constraint f_rfp_pais_2_pk primary key (pais_id)
)
;



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
)
;



