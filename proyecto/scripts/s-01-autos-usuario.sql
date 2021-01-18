--@Author:              Rodrigo Francisco Pablo 
--@Fecha de creacion:   14/01/2021
--@Descripcion:         Eliminacion y creacion de usuarios

declare
v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where lower(username) ='autos_bdd';
  if v_count > 0 then
    execute immediate 'drop user autos_bdd cascade';
  else
    dbms_output.put_line('El usuario autos_bdd no existe');
  end if;
end;
/

Prompt Creando al usuario autos_bdd
create user autos_bdd identified by autos_bdd quota unlimited on users;

Prompt Otorgando privilegios a autos_bdd
grant create session, create table, create sequence, 
create procedure, create view, create synonym, create database link
to autos_bdd;

