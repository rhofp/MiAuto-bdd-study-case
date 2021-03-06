--
-- ER/Studio 8.0 SQL Code Generation
-- Company :      unam.fi
-- Project :      modelo-global.DM1
-- Author :       rho
--
-- Date Created : Sunday, January 17, 2021 22:57:20
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: CLIENTE_F2_EFM_S1 
--

CREATE TABLE CLIENTE_F2_EFM_S1(
    CLIENTE_ID            NUMBER(10, 0)    NOT NULL,
    NOMBRE                VARCHAR2(40)     NOT NULL,
    AP_PATERNO            VARCHAR2(40)     NOT NULL,
    AP_MATERNO            VARCHAR2(40)     NOT NULL,
    NUM_IDENTIFICACION    VARCHAR2(18)     NOT NULL,
    EMAIL                 VARCHAR2(500)    NOT NULL,
    CONSTRAINT CLIENTE_PK PRIMARY KEY (CLIENTE_ID)
)
;



-- 
-- TABLE: STATUS_AUTO 
--

CREATE TABLE STATUS_AUTO(
    STATUS_AUTO_ID    NUMBER(2, 0)    NOT NULL,
    CLAVE             VARCHAR2(20)    NOT NULL,
    DESCRIPCION       VARCHAR2(40)    NOT NULL,
    CONSTRAINT STATUS_AUTO_PK PRIMARY KEY (STATUS_AUTO_ID)
)
;



-- 
-- TABLE: historico_status_auto_F1_EFM_S1 
--

CREATE TABLE historico_status_auto_F1_EFM_S1(
    HISTORICO_STATUS_ID    NUMBER(10, 0)    NOT NULL,
    FECHA_STATUS           DATE             NOT NULL,
    STATUS_AUTO_ID         NUMBER(2, 0)     NOT NULL,
    AUTO_ID                NUMBER(10, 0)    NOT NULL,
    CONSTRAINT historico_status_auto_PK PRIMARY KEY (HISTORICO_STATUS_ID), 
    CONSTRAINT HIST_STATUS_F1_STA_ID_FK FOREIGN KEY (STATUS_AUTO_ID)
    REFERENCES STATUS_AUTO(STATUS_AUTO_ID)
)
;



-- 
-- TABLE: MARCA_R_EFM_S1 
--

CREATE TABLE MARCA_R_EFM_S1(
    MARCA_ID       NUMBER(3, 0)     NOT NULL,
    CLAVE          VARCHAR2(50)     NOT NULL,
    DESCRIPCION    VARCHAR2(500)    NOT NULL,
    ACTIVO         NUMBER(1, 0)     NOT NULL,
    CONSTRAINT MARCA_PK PRIMARY KEY (MARCA_ID)
)
;



-- 
-- TABLE: MODELO_R_EFM_S1 
--

CREATE TABLE MODELO_R_EFM_S1(
    MODELO_ID      NUMBER(10, 0)    NOT NULL,
    CLAVE          VARCHAR2(50)     NOT NULL,
    DESCRIPCION    VARCHAR2(500)    NOT NULL,
    ACTIVO         NUMBER(1, 0)     NOT NULL,
    MARCA_ID       NUMBER(3, 0)     NOT NULL,
    CONSTRAINT MODELO_PK PRIMARY KEY (MODELO_ID), 
    CONSTRAINT MODELO_R_MARCA_ID_FK FOREIGN KEY (MARCA_ID)
    REFERENCES MARCA_R_EFM_S1(MARCA_ID)
)
;



-- 
-- TABLE: SUCURSAL_F3_EFM_S1 
--

CREATE TABLE SUCURSAL_F3_EFM_S1(
    SUCURSAL_ID          NUMBER(10, 0)    NOT NULL,
    SUCURSAL_ANEXA_ID    NUMBER(10, 0),
    NOMBRE               VARCHAR2(40)     NOT NULL,
    CLAVE                VARCHAR2(8)      NOT NULL,
    PAIS_ID              NUMBER(10, 0)    NOT NULL,
    CONSTRAINT SUCURSAL_PK PRIMARY KEY (SUCURSAL_ID)
)
;



-- 
-- TABLE: TARJETA_CLIENTE_F2_EFM_S1 
--

CREATE TABLE TARJETA_CLIENTE_F2_EFM_S1(
    CLIENTE_ID          NUMBER(10, 0)    NOT NULL,
    NUM_TARJETA         VARCHAR2(16)     NOT NULL,
    CODIGO_SEGURIDAD    NUMBER(3, 0)     NOT NULL,
    CONSTRAINT TARJETA_CLIENTE_PK PRIMARY KEY (CLIENTE_ID)
)
;



