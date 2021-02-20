--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   14/01/2021
--@Descripcion:         Eliminacion y creacion de usuarios

clear screen
whenever sqlerror exit rollback;
Prompt ============================
Prompt Creando ligas en rfpbd_s1
Prompt ============================

--Ligas en la pdb rfpbd_s1
Prompt Creando ligas en rfpbd_s1
connect autos_bdd/autos_bdd@rfpbd_s1
-- PDB local
create database link rfpbd_s2.fi.unam using 'RFPBD_S2';
--PDB remotas
create database link efmbd_s1.fi.unam using 'EFMBD_S1';
Create database link efmbd_s2.fi.unam using 'EFMBD_S2';

--Ligas en la pdb rfpbd_s2
connect autos_bdd/autos_bdd@rfpbd_s2
-- PDB local
create database link rfpbd_s1.fi.unam using 'RFPBD_S1';
--PDB remotas
create database link efmbd_s1.fi.unam using 'EFMBD_S1';
Create database link efmbd_s2.fi.unam using 'EFMBD_S2';

--Ligas en la pdb efmbd_s1
connect autos_bdd/autos_bdd@efmbd_s1
-- PDB local
create database link efmbd_s2.fi.unam using 'EFMBD_S2';
--PDB remotas
create database link rfpbd_s1.fi.unam using 'RFPBD_S1';
Create database link rfpbd_s2.fi.unam using 'RFPBD_S2';

--Ligas en la pdb efmbd_s2
connect autos_bdd/autos_bdd@efmbd_s2
-- PDB local
create database link efmbd_s1.fi.unam using 'EFMBD_S1';
--PDB remotas
create database link rfpbd_s1.fi.unam using 'RFPBD_S1';
Create database link rfpbd_s2.fi.unam using 'RFPBD_S2';

Prompt Listo!
disconnect
