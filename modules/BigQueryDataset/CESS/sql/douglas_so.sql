insert into `emea-crunch-gbl-emea-{env}.d_crunch_cess_dom_{env}.t_lpd_douglas_b-o_so` (EAN_UPC_CODE,SOLD_QUANTITY_IN_UNITS,POS_OR_WEBSITE_CODE,INSERT_DATETIME, UPDATE_DATETIME,SHOPPING_CHANNEL,RUN_ID)




with Header_Data AS(

SELECT * FROM `emea-crunch-gbl-emea-{env}.d_crunch_cess_stg_{env}.t_lpd_douglas_b-o_so` 
UNPIVOT ((SOLD_QUANTITY_IN_UNITS) for POS_OR_WEBSITE_CODE in (POS_001,POS_002,POS_003,POS_004,POS_005,POS_006,POS_007,POS_008,POS_009,POS_010,POS_011,POS_012,POS_013,POS_014,POS_015,POS_016,POS_017,POS_018,POS_019,POS_020,POS_021,POS_022,POS_023,POS_024,POS_025,POS_026,POS_027,POS_028,POS_029,POS_030,POS_031,POS_033,POS_034,POS_035,POS_036,POS_037,POS_038,POS_039,POS_397))
where EAN is null and Vanzari_total = 'Total' and RUN_ID = '{run_id}'
),

Retailer_Data AS(

  Select * from `emea-crunch-gbl-emea-{env}.d_crunch_cess_stg_{env}.t_lpd_douglas_b-o_so`  

  where EAN IS NOT NULL and Vanzari_total <> 'Vanzari in bucati' and RUN_ID = '{run_id}'

)

Select a.EAN as EAN_UPC_CODE, a.SOLD_QUANTITY_IN_UNITS, b.SOLD_QUANTITY_IN_UNITS As POS_OR_WEBSITE_CODE, current_datetime() as INSERT_DATETIME , current_datetime() as UPDATE_DATETIME,case when b.SOLD_QUANTITY_IN_UNITS='397' then 'O'
  else 'B' end as SHOPPING_CHANNEL,a.RUN_ID

from 

(
Select * from Retailer_Data a

  UNPIVOT ((SOLD_QUANTITY_IN_UNITS) for POS_OR_WEBSITE_CODE in (POS_001,POS_002,POS_003,POS_004,POS_005,POS_006,POS_007,POS_008,POS_009,POS_010,POS_011,POS_012,POS_013,POS_014,POS_015,POS_016,POS_017,POS_018,POS_019,POS_020,POS_021,POS_022,POS_023,POS_024,POS_025,POS_026,POS_027,POS_028,POS_029,POS_030,POS_031,POS_033,POS_034,POS_035,POS_036,POS_037,POS_038,POS_039,POS_397) )


) A

LEFT JOIN Header_Data B

ON A.POS_OR_WEBSITE_CODE = B.POS_OR_WEBSITE_CODE

where a.RUN_ID = '{run_id}'





