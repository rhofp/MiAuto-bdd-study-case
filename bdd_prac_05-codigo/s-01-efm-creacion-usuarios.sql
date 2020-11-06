--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/11/2020
--@Descripción:     Creación de usuarios para la máquina pc-efm

prompt Conectandose a efmbd_s1 como usuario SYS
connect sys@efmbd_s1 as sysdba
prompt Creando usuario editorial_bdd

declare
  v_count number;
  v_username varchar2(30) := 'editorial_bdd';
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
    execute immediate 'grant create session, create table, create sequence, 
    create procedure to '|| v_username;
  else 
    dbms_output.put_line('El usuario '||v_username||' ya existe');
  end if;

end;
/

prompt Conectandose a efmbd_s2 como usuario SYS
connect sys@efmbd_s2 as sysdba
prompt Creando usuario editorial_bdd

declare
  v_count number;
  v_username varchar2(30) := 'editorial_bdd';
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
    execute immediate 'grant create session, create table, create sequence, 
    create procedure to '|| v_username;
  else 
    dbms_output.put_line('El usuario '||v_username||' ya existe');
  end if;

end;
/

prompt Listo!
exit
