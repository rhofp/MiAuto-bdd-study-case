--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   14/01/2021
--@Descripcion:         Creacion de usuarios en los 4 nodos

clear screen
whenever sqlerror exit rollback;
set serveroutput on

Prompt Inciando creacion/eliminacion de usuarios.
accept syspass char prompt 'Proporcione el password de sys: ' hide

prompt =====================================
prompt Creando usuario en rfpbd_s1
prompt =====================================
connect sys/&&syspass@rfpbd_s1 as sysdba
@s-01-autos-usuario.sql

prompt =====================================
prompt Creando usuario en rfpbd_s2
prompt =====================================
connect sys/&&syspass@rfpbd_s2 as sysdba
@s-01-autos-usuario.sql

prompt =====================================
prompt Creando usuario en efmbd_s1
prompt =====================================
connect sys/&&syspass@efmbd_s1 as sysdba
@s-01-autos-usuario.sql

prompt =====================================
prompt Creando usuario en efmbd_s2
prompt =====================================
connect sys/&&syspass@efmbd_s2 as sysdba
@s-01-autos-usuario.sql

Prompt Listo!
disconnect
