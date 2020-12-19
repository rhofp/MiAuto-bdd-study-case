-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion: Script encargado de realizar consultas para comprobar ligas

prompt conectando a rfpbd_s2
connect editorial_bdd/editorial_bdd@rfpbd_s2

set serveroutput on

prompt Realizando conteo de registros

--La consulta se lanza en rfpbd_s2
declare
  v_num_paises number;
  v_num_suscriptores number;
  v_num_articulos number;
  v_num_revistas number;
  v_num_articulo_revistas number;
  v_num_pago_suscriptores number;
  
  begin

    dbms_output.put_line('Realizando consulta empleando ligas');

    --consultando paises
    select count(*) as into v_num_paises
    from (
      select pais_id
      from F_RFP_PAIS_1@rfpbd_s1.fi.unam
      union all
      select pais_id
      from F_RFP_PAIS_2
    ) q1;

    select count(*) as into v_num_suscriptores
    from (
      select s1.suscriptor_id from F_RFP_SUSCRIPTOR_1@rfpbd_s1.fi.unam s1
      join (
        select suscriptor_id
        from F_RFP_SUSCRIPTOR_2@rfpbd_s1.fi.unam
        union all 
        select suscriptor_id
        from F_RFP_SUSCRIPTOR_3@rfpbd_s1.fi.unam
        union all 
        select suscriptor_id
        from F_RFP_SUSCRIPTOR_4
      ) sq1
      on sq1.suscriptor_id = s1.suscriptor_id
    ) q2;

    select count(*) as into v_num_articulos
    from (
      select a2.articulo_id
      from F_RFP_ARTICULO_2@rfpbd_s1.fi.unam a2
      join F_RFP_ARTICULO_1 a1
      on a2.articulo_id = a1.articulo_id
    ) q3;

    select count(*) as into v_num_revistas
    from (
      select revista_id
      from F_RFP_REVISTA_1@rfpbd_s1.fi.unam
      union all
      select revista_id
      from F_RFP_REVISTA_2
    ) q4;

    select count(*) as into v_num_articulo_revistas
    from (
      select revista_id
      from F_RFP_ARTICULO_REVISTA_1@rfpbd_s1.fi.unam
      union all
      select revista_id
      from F_RFP_ARTICULO_REVISTA_2
    ) q5;

    select count(*) as into v_num_pago_suscriptores
    from (
      select num_pago
      from F_RFP_PAGO_SUSCRIPTOR_1@rfpbd_s1.fi.unam
      union all
      select num_pago
      from F_RFP_PAGO_SUSCRIPTOR_2
    ) q5;

dbms_output.put_line('Resultado del conteo de registros');
dbms_output.put_line('============        ===============');
dbms_output.put_line('Paises:           '||v_num_paises);
dbms_output.put_line('Suscriptores:     '||v_num_suscriptores);
dbms_output.put_line('Articulos:        '||v_num_articulos);
dbms_output.put_line('Revistas:         '||v_num_revistas);
dbms_output.put_line('Articulo Revista: '||v_num_articulo_revistas);
dbms_output.put_line('Pago suscriptor:  '||v_num_pago_suscriptores);
end;
/

Prompt Listo!
exit
