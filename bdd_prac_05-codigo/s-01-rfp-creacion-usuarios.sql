--@Autor: Francisco Pablo Rodrigo
--@Fecha creacion: 03 de noviembre de 2020
--@Descripcion: Creacion de usuarios en PDBs

prompt Conectandose a rfpbd_s1 como usuario SYS
connect sys@rfpbd_s1 as sysdba
prompt creando usuario editorial_bdd en rfpbd_s1

declare
  v_count number;
  v_username varchar2(30) := 'EDITORIAL_BDD';
begin
  select count(*) into v_count
  from all_users
  where username = v_username;

  if v_count = 0 then
    -- Creando usuario
    execute immediate 'create user '
    || v_username
    || ' identified by editorial_bdd quota unlimited on users';
    -- Otorgando permisos al usuario
    execute immediate 'grant create table, create session, create sequence, 
    create procedure to '|| v_username;
  else 
    dbms_output.put_line('El usuario '||v_username||' ya existe');
  end if;

end;
/

prompt conectandose a rfpbd_s2 como usuario SYS
connect sys@rfpbd_s2 as sysdba
prompt creando usuario editorial_bdd en rfpbd_s2

declare
  v_count number;
  v_username varchar2(30) := 'EDITORIAL_BDD';
begin
  select count(*) into v_count
  from all_users
  where username = v_username;

  if v_count = 0 then
    -- Creando usuario
    execute immediate 'create user '
    || v_username
    || ' identified by editorial_bdd quota unlimited on users';
    -- Otorgando permisos al usuario
    execute immediate 'grant create table, create session, create sequence, 
    create procedure to '|| v_username;
  else 
    dbms_output.put_line('El usuario '||v_username||' ya existe');
  end if;

end;
/
prompt Listo
exit