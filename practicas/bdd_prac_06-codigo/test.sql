-- @Autor: Francisco Pablo Rodrigo
-- @Fecha creacion: 01/12/2010
-- @Descripcion: Script encargado de realizar consultas para comprobar ligas

prompt conectando a rfpbd_s1
connect editorial_bdd/editorial_bdd@rfpbd_s1

select count(*) from (
select s1.suscriptor_id from F_RFP_SUSCRIPTOR_1 s1
join (
  select suscriptor_id
  from F_RFP_SUSCRIPTOR_2
  union all 
  select suscriptor_id
  from F_RFP_SUSCRIPTOR_3
  union all 
  select suscriptor_id
  from F_RFP_SUSCRIPTOR_4@rfpbd_s2.fi.unam
) sq1
on sq1.suscriptor_id = s1.suscriptor_id
) q1;