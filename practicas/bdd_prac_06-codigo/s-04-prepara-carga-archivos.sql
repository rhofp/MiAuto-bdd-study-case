--@Autor: Francisco Pablo Rodrigo
--@Fecha creación: 05/12/2020
--@Descripción: Carga y Export de archivos PDF 

whenever sqlerror exit rollback;

--ruta donde se ubicarán los archivos PDFs
define p_pdf_path='/tmp/bdd/p06'
set verify off

Prompt Limpiando y creando directorio en /tmp/bdd/p06
!rm -rf &p_pdf_path
!mkdir -p &p_pdf_path
!chmod 777 &p_pdf_path

-- Se asume que los PDFs se encuentran en el mismo directorio donde se
-- ejecuta este script.
!cp m_archivo_*.pdf &p_pdf_path
!chmod 755 &p_pdf_path/m_archivo_*.pdf

--rfpbd_s1
Prompt conectando a rfpbd_s1 como SYS para crear objetos tipo directory
accept p_sys_password default 'system' prompt 'Password de sys [system]: ' hide
connect sys@rfpbd_s1/&p_sys_password as sysdba

Prompt creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to editorial_bdd;

--rfpbd_s2

Prompt conectando a rfpbd_s2 como SYS para crear objetos tipo directory
accept p_sys_password default 'system' prompt 'Password de sys [system]: ' hide
connect sys@rfpbd_s2/&p_sys_password as sysdba

Prompt creando un objeto DIRECTORY para acceder al directorio /tmp/bdd/p06
create or replace directory tmp_dir as '&p_pdf_path';
grant read,write on directory tmp_dir to editorial_bdd;

-- Inciando la carga de archivos binarios

Prompt conectando a rfpbd_s1 con usuario editorial_bdd para cargar datos binarios
connect editorial_bdd/editorial_bdd@rfpbd_s1

/*
* En este sitio se cargarán los siguientes archivos.
* F_JRC_PAGO_SUSCRIPTOR_1
* NUM_PAGO  SUSCRIPTOR_ID    RECIBO_PAGO
* --------- -------------    ----------
* 1                     1    m_archivo_3.pdf
*
*/
 Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

Prompt cargando datos binarios en rfpbd_s1

begin
  carga_blob_en_bd('TMP_DIR','m_archivo_3.pdf','f_rfp_pago_suscriptor_1',
  'recibo_pago','num_pago','1','suscriptor_id','1');
end;
/

Prompt mostrando el tamaño de los objetos BLOB en BD.

Prompt para f_rfp_pago_suscriptor_1:
select num_pago,suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from f_rfp_pago_suscriptor_1;

Prompt salvando datos BLOB en directorio TMP_DIR

begin
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_3.pdf',
  'f_rfp_pago_suscriptor_1','recibo_pago','num_pago','1','suscriptor_id','1');
end;
/

Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_export_archivo_*.pdf

------------------ Cargando datos en rfpbd_s2 ----------------------
-- Inciando la carga de archivos binarios

Prompt conectando a rfpbd_s2 con usuario editorial_bdd para cargar datos binarios
connect editorial_bdd/editorial_bdd@rfpbd_s2

 Prompt ejecutando procedimientos para hacer import/export de datos BLOB
@s-00-carga-blob-en-bd.sql
@s-00-guarda-blob-en-archivo.sql

Prompt cargando datos binarios en rfpbd_s2

begin
  carga_blob_en_bd('TMP_DIR','m_archivo_1.pdf','f_rfp_articulo_1',
  'pdf','articulo_id','1',null,null);
  carga_blob_en_bd('TMP_DIR','m_archivo_2.pdf','f_rfp_articulo_1',
  'pdf','articulo_id','2',null,null);
  carga_blob_en_bd('TMP_DIR','m_archivo_4.pdf','f_rfp_pago_suscriptor_2',
  'recibo_pago','num_pago','70','suscriptor_id','2');
end;
/

Prompt mostrando el tamaño de los objetos BLOB en BD.

Prompt para f_rfp_pago_suscriptor_2:
select num_pago,suscriptor_id,dbms_lob.getlength(recibo_pago) as longitud
from f_rfp_pago_suscriptor_2;

Prompt para f_rfp_articulo_1:
select articulo_id,dbms_lob.getlength(pdf) as longitud
from f_rfp_articulo_1;

Prompt salvando datos BLOB en directorio TMP_DIR

begin
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_3.pdf',
  'f_rfp_pago_suscriptor_2','recibo_pago','num_pago','70','suscriptor_id','2');
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_1.pdf',
  'f_rfp_articulo_1','pdf','articulo_id','1',null,null);
  guarda_blob_en_archivo('TMP_DIR','m_export_archivo_2.pdf',
  'f_rfp_articulo_1','pdf','articulo_id','2',null,null);
end;
/

Prompt mostrando el contenido del directorio para validar la existencia del archivo.
!ls -l &p_pdf_path/m_export_archivo_*.pdf

Prompt Listo!
disconnect

