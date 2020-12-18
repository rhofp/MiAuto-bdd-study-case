--@Author:	    	Emanuel Flores Martínez
--@Fecha creación:  16/12/2020
--@Descripción:     Script encargado de realizar consultas con sinonimos.
--                  EL script se puede ejecutar en cualquier PDB

declare
  v_num_paises number;
  v_num_suscriptores number;
  v_num_articulos number;
  v_num_revistas number;
  v_num_articulo_revista number;
  v_num_pago_suscriptor number;
begin

  dbms_output.put_line('Realizando consulta empleando sinonimos');

  --consultando paises
  select count(*) as into v_num_paises
  from (
    select pais_id
    from pais_1
    union all
    select pais_id
    from pais_2
  ) q1;

  --consultado suscriptores
  select count(*) as into v_num_suscriptores
  from (
    select suscriptor_id 
    from suscriptor_2
    union all
    select suscriptor_id 
    from suscriptor_3
    union all
    select suscriptor_id 
    from suscriptor_4
  ) s2
  join suscriptor_1 s1
  on s2.suscriptor_id = s1.suscriptor_id;

  --consultado articulos
  select count(*) as into v_num_articulos
  from articulo_2 a2
  join articulo_1 a1
  on a2.articulo_id = a1.articulo_id;

  --consultando revistas
  select count(*) as into v_num_revistas
  from (
    select revista_id
    from revista_1
    union all 
    select revista_id 
    from revista_2
  ) r1;

  --consultando articulo_revistas
  select count(*) as into v_num_articulo_revista
  from (
    select articulo_revista_id
    from articulo_revista_1
    union all 
    select articulo_revista_id
    from articulo_revista_2
  ) ar1;

  select count(*) as into v_num_pago_suscriptor
  from (
    select suscriptor_id
    from pago_suscriptor_1
    union all 
    select suscriptor_id
    from pago_suscriptor_2
  ) ar1;

  dbms_output.put_line('Resultado del conteo de registros');
  dbms_output.put_line('==================================');
  dbms_output.put_line('Paises:           '|| v_num_paises);
  dbms_output.put_line('Suscriptores:     '|| v_num_suscriptores);
  dbms_output.put_line('Artículos:        '|| v_num_articulos);
  dbms_output.put_line('Revistas:         '|| v_num_revistas);
  dbms_output.put_line('Artículo Revista: '|| v_num_articulo_revista);
  dbms_output.put_line('Pago Suscriptor:  '|| v_num_pago_suscriptor);

end;
/

