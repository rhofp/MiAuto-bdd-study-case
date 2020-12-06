--@Author:	    Emanuel Flores Martínez
--@Fecha creación:  05/12/2020
--@Descripción:     Contando registros desde el sitio 2

prompt conectando a efmbd_s2
connect editorial_bdd/editorial_bdd@efmbd_s2
prompt Realizando conteo de registros
set serveroutput on

--La consulta se lanza en EFMBD_S2
declare
  v_num_paises number;
  v_num_suscriptores number;
  v_num_articulos number;
  v_num_revistas number;
  v_num_articulo_revista number;
  v_num_pago_suscriptor number;
begin

  dbms_output.put_line('Realizando consulta empleando ligas');

  --consultando paises
  select count(*) as into v_num_paises
  from (
    select pais_id
    from F_EFM_PAIS_1@efmbd_s1.fi.unam
    union all
    select pais_id
    from F_EFM_PAIS_2
  ) q1;

  --consultado suscriptores
  select count(*) as into v_num_suscriptores
  from (
    select suscriptor_id 
    from F_EFM_SUSCRIPTOR_2@efmbd_s1.fi.unam
    union all
    select suscriptor_id 
    from F_EFM_SUSCRIPTOR_3@efmbd_s1.fi.unam
    union all
    select suscriptor_id 
    from F_EFM_SUSCRIPTOR_4
  ) s2
  join F_EFM_SUSCRIPTOR_1@efmbd_s1.fi.unam s1
  on s2.suscriptor_id = s1.suscriptor_id;

  --consultado articulos
  select count(*) as into v_num_articulos
  from F_EFM_ARTICULO_2@efmbd_s1.fi.unam a2
  join F_EFM_ARTICULO_1 a1
  on a2.articulo_id = a1.articulo_id;

  --consultando revistas
  select count(*) as into v_num_revistas
  from (
    select revista_id
    from F_EFM_REVISTA_1@efmbd_s1.fi.unam  r1
    union all 
    select revista_id 
    from F_EFM_REVISTA_2 r2
  ) r1;

  --consultando articulo_revistas
  select count(*) as into v_num_articulo_revista
  from (
    select articulo_revista_id
    from F_EFM_ARTICULO_REVISTA_1@efmbd_s1.fi.unam
    union all 
    select articulo_revista_id
    from F_EFM_ARTICULO_REVISTA_2
  ) ar1;

  select count(*) as into v_num_pago_suscriptor
  from (
    select suscriptor_id
    from F_EFM_PAGO_SUSCRIPTOR_1@efmbd_s1.fi.unam
    union all 
    select suscriptor_id
    from F_EFM_PAGO_SUSCRIPTOR_2
  ) ar1;

  dbms_output.put_line('Resultado del conteo de registros');
  dbms_output.put_line('==================================');
  dbms_output.put_line('Paises:                 '|| v_num_paises);
  dbms_output.put_line('Suscriptores:           '|| v_num_suscriptores);
  dbms_output.put_line('Artículos:              '|| v_num_articulos);
  dbms_output.put_line('Revistas:               '|| v_num_revistas);
  dbms_output.put_line('Artículo Revista:       '|| v_num_articulo_revista);
  dbms_output.put_line('Pago Suscriptor:        '|| v_num_pago_suscriptor);

end;
/

Prompt Listo!
exit