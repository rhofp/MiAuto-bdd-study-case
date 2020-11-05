--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Implementación de fragmentos en N1 - Código DDL

prompt Creando tablas para el sitio N1

create or replace procedure drop_table_if_exists(name in varchar2) is
	v_count number;
begin
	select count(*) 
	into v_count 
	from all_tables 
	where table_name = name;
	
	if (v_count > 0) then
       		execute immediate 'drop table ' || name || ' cascade constraints';
	end if;
end;
/

declare
	v_articulo_revista1 varchar2(30):= 'F_EFM_ARTICULO_REVISTA_1';
	v_pago_suscriptor1 varchar2(30)	:= 'F_EFM_PAGO_SUSCRIPTOR_1';
	v_suscriptor1 varchar2(30) 	:= 'F_EFM_SUSCRIPTOR_1';
	v_suscriptor2 varchar2(30)	:= 'F_EFM_SUSCRIPTOR_2';
	v_suscriptor3 varchar2(30) 	:= 'F_EFM_SUSCRIPTOR_3';
	v_articulo2 varchar2(30) 	:= 'F_EFM_ARTICULO_2';
	v_revista1 varchar2(30) 	:= 'F_EFM_REVISTA_1';
	v_pais1 varchar2(30) 		:= 'F_EFM_PAIS_1';
begin
	drop_table_if_exists(v_articulo_revista1);
	drop_table_if_exists(v_pago_suscriptor1);
	drop_table_if_exists(v_suscriptor1);
	drop_table_if_exists(v_suscriptor2);
	drop_table_if_exists(v_suscriptor3);
	drop_table_if_exists(v_articulo2);
	drop_table_if_exists(v_revista1);
	drop_table_if_exists(v_pais1);
end;
/

--
-- Fragmento: F_EFM_PAIS_1
--
create table f_efm_pais_1 (
    pais_id             number(3, 0)    not null,
    clave               varchar2(3)     not null,
    nombre              varchar2(40)    not null,
    region_economica    char(1)         not null,
    constraint f_efm_pais_1_pk primary key (pais_id)
);

--
-- Fragmento: F_EFM_REVISTA_1
--
create table f_efm_revista_1 (
    revista_id              number(10, 0)    not null,
    folio                   varchar2(10)     not null,
    titulo                  varchar2(40)     not null,
    fecha_publicacion       date             not null,
    revista_adicional_id    number(10, 0)    not null,
    constraint f_efm_revista_1_pk primary key (revista_id)
);

--
-- Fragmento: F_EFM_ARTICULO_2
--
create table f_efm_articulo_2 (
    articulo_id    number(10, 0)     not null,
    titulo         varchar2(40)      not null,
    resumen        varchar2(500)     not null,
    texto          varchar2(4000)    not null,
    constraint f_efm_articulo_2_pk primary key (articulo_id)
);

--
-- Fragmento: F_EFM_SUSCRIPTOR_3
--
create table f_efm_suscriptor_3 (
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40),
    fecha_inscripcion    date             not null,
    pais_id              number(3, 0)     not null,
    constraint f_efm_suscriptor_3_pk primary key (suscriptor_id)
);

--
-- Fragmento: F_EFM_SUSCRIPTOR_2
--
create table f_efm_suscriptor_2 (
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40),
    fecha_inscripcion    date             not null,
    pais_id              number(3, 0)     not null,
    constraint f_efm_suscriptor_2_pk primary key (suscriptor_id),
    constraint f_efm_suscriptor_2_pais_id_fk foreign key (pais_id)
    references f_efm_pais_1 (pais_id)
);

--
-- Fragmento: F_EFM_SUSCRIPTOR_1
--
create table f_efm_suscriptor_1 (
    suscriptor_id    number(10, 0)    not null,
    num_tarjeta      varchar2(16)     not null,
    constraint f_efm_suscriptor_1_pk primary key (suscriptor_id)
);

--
-- Fragmento: F_EFM_PAGO_SUSCRIPTOR_1
--
create table f_efm_pago_suscriptor_1 (
    num_pago         number(10, 0)    not null,
    suscriptor_id    number(10, 0)    not null,
    fecha_pago       date             not null,
    importe          number(8, 2)     not null,
    recibo_pago      blob             not null,
    constraint f_efm_pago_suscriptor_1 primary key (num_pago, suscriptor_id),
    constraint pago_suscriptor_1_suscriptor_id_fk foreign key (suscriptor_id)
    references f_efm_suscriptor_1 (suscriptor_id)
);

--
-- Fragmento F_EFM_ARTICULO_REVISTA_1
--
create table f_efm_articulo_revista_1 (
    articulo_revista_id    number(10, 0)    not null,
    fecha_aprobacion       date             not null,
    calificacion           number(3, 1)     not null,
    revista_id             number(10, 0)    not null,
    articulo_id            number(10, 0)    not null,
    constraint f_efm_articulo_revista_1_pk primary key (articulo_revista_id),
    constraint f_efm_articulo_revista_1_revista_id_fk foreign key (revista_id)
    references f_efm_revista_1 (revista_id),
    constraint f_efm_articulo_revista_1_articulo_id_fk foreign key (articulo_id)
    references f_efm_articulo_2 (articulo_id)
);

