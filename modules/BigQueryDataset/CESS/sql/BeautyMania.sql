insert into `emea-crunch-gbl-emea-{env}.d_crunch_cess_dom_{env}.t_lpd_beautymania_b-o` (COD_EXTERN,SOLD_QUANTITY_IN_UNITS,POS_OR_WEBSITE_NAME,INSERT_DATETIME, UPDATE_DATETIME,SHOPPING_CHANNEL,RUN_ID)


with Header_Data AS(

SELECT * FROM `emea-crunch-gbl-emea-{env}.d_crunch_cess_stg_{env}.t_lpd_beautymania_b-o` 
UNPIVOT ((SOLD_QUANTITY_IN_UNITS) for POS_OR_WEBSITE_NAME in (WWW,Iasi1,Onesti,Roman,Botosani1,Bacau,Vaslui,Botosani2,Barlad,PiatraNeamt,Iasi2))
where Clasaarticole='Grand Total' and RUN_ID = '{run_id}'),

Retailer_Data AS(
Select * from `emea-crunch-gbl-emea-{env}.d_crunch_cess_stg_{env}.t_lpd_beautymania_b-o`  

where Clasaarticole NOT like  '% Total' and Clasaarticole NOT IN ('Grand Total','Clasa articole') and RUN_ID = '{run_id}'
)


Select a.CODEXTERN as EAN_UPC_CODE, a.SOLD_QUANTITY_IN_UNITS,b.POS_OR_WEBSITE_NAME,current_datetime() as INSERT_DATETIME, current_datetime() as UPDATE_DATETIME, case when b.POS_OR_WEBSITE_NAME='WWW' then 'O'
  else 'B' end as SHOPPING_CHANNEL,a.RUN_ID


from
(
Select * from Retailer_Data a

  UNPIVOT ((SOLD_QUANTITY_IN_UNITS) for POS_OR_WEBSITE_NAME in (WWW,Iasi1,Onesti,Roman,Botosani1,Bacau,Vaslui,Botosani2,Barlad,PiatraNeamt,Iasi2))

) A


LEFT JOIN Header_Data B 

ON A.POS_OR_WEBSITE_NAME = B.POS_OR_WEBSITE_NAME

WHERE A.SOLD_QUANTITY_IN_UNITS is not null and SAFE_CAST(A.SOLD_QUANTITY_IN_UNITS AS INTEGER) <>0
and a.RUN_ID = '{run_id}'
