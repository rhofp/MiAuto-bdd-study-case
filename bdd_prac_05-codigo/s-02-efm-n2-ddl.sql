--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Implementación de fragmentos en N1 - Código DDL

prompt Conectandose a efmbd_s2 como usuario EDITORIAL_BDD
connect editorial_bdd/editorial_bdd@efmbd_s2

prompt Creando tablas para el sitio N2

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
	v_articulo_revista2 varchar2(30):= 'F_EFM_ARTICULO_REVISTA_2';
	v_pago_suscriptor_2 varchar(30) := 'F_EFM_PAGO_SUSCRIPTOR_2';
	v_suscriptor4 varchar2(30) 	:= 'F_EFM_SUSCRIPTOR_4';
	v_articulo1 varchar2(30) 	:= 'F_EFM_ARTICULO_1';
	v_revista2 varchar2(30) 	:= 'F_EFM_REVISTA_2';
	v_pais2 varchar2(30) 		:= 'F_EFM_PAIS_2';
	
begin
	drop_table_if_exists(v_articulo_revista2);
	drop_table_if_exists(v_pago_suscriptor_2);
	drop_table_if_exists(v_suscriptor4);
	drop_table_if_exists(v_articulo1);
	drop_table_if_exists(v_revista2);
	drop_table_if_exists(v_pais2);
end;
/

-- 
-- Fragmento: F_EFM_REVISTA_2 
--
create table f_efm_revista_2 (
    revista_id              number(10, 0)    not null,
    folio                   varchar2(10)     not null,
    titulo                  varchar2(40)     not null,
    fecha_publicacion       date             not null,
    revista_adicional_id    number(10, 0)    not null,
    constraint f_efm_revista_2_pk primary key (revista_id)
);

-- 
-- Fragmento: F_EFM_PAIS_2 
--
create table f_efm_pais_2 (
    pais_id             number(3, 0)    not null,
    clave               varchar2(3)     not null,
    nombre              varchar2(40)    not null,
    region_economica    char(1)         not null,
    constraint f_efm_pais_2_pk primary key (pais_id)
);

-- 
-- Fragmento: F_EFM_ARTICULO_1 
--
create table f_efm_articulo_1 (
    articulo_id    number(10, 0)    not null,
    pdf            blob             not null,
    constraint f_efm_articulo_1_pk primary key (articulo_id)
);

-- 
-- Fragmento: F_EFM_PAGO_SUSCRIPTOR_2
--
create table f_efm_pago_suscriptor_2 (
    num_pago         number(10, 0)    not null,
    suscriptor_id    number(10, 0)    not null,
    fecha_pago       date             not null,
    importe          number(8, 2)     not null,
    recibo_pago      blob             not null,
    constraint f_efm_pago_suscriptor_2_pk primary key (num_pago, suscriptor_id)
);

-- 
-- Fragmento: F_EFM_SUSCRIPTOR_4 
--
create table f_efm_suscriptor_4 (
    suscriptor_id        number(10, 0)    not null,
    nombre               varchar2(40)     not null,
    ap_paterno           varchar2(40)     not null,
    ap_materno           varchar2(40),
    fecha_inscripcion    date             not null,
    pais_id              number(3, 0)     not null,
    constraint f_efm_suscriptor_4_pk primary key (suscriptor_id),
    constraint f_efm_suscriptor_4_pais_id_fk foreign key (pais_id)
    references f_efm_pais_2 (pais_id)
);

-- 
-- Fragmento: F_EFM_ARTICULO_REVISTA_2 
--
create table f_efm_articulo_revista_2 (
    articulo_revista_id    number(10, 0)    not null,
    fecha_aprobacion       date             not null,
    calificacion           number(3, 1)     not null,
    articulo_id            number(10, 0)    not null,
    revista_id             number(10, 0)    not null,
    constraint f_efm_articulo_revista_2_pk primary key (articulo_revista_id),
    constraint f_efm_articulo_revista_2_articulo_id_fk foreign key (articulo_id)
    references f_efm_articulo_1 (articulo_id),
    constraint f_efm_articulo_revista_2_revista_id_fk foreign key (revista_id)
    references f_efm_revista_2 (revista_id)
);









