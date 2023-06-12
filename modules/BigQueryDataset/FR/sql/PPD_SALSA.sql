MERGE  `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_ppd_salsa_b` D
USING  (
SELECT CodeBarre, Dispo, quantity, month, periode, FORMAT_DATE('%Y%m%d', CAST( CONCAT(
              SUBSTR(periode, 1 , 4), 
              '-' ,
              SUBSTR(periode, 5 , 6), 
              '-' , 
              '01') 
             AS DATE
          )) AS PERIOD_START_DATE,
         FORMAT_DATE('%Y%m%d',  DATE_SUB(DATE_TRUNC(DATE_ADD(CAST(
            CONCAT(
              SUBSTR(periode, 1 , 4), 
              '-' ,
              SUBSTR(periode, 5 , 6), 
              '-' , 
              '01') 
             AS DATE
          ), INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)) AS PERIOD_END_DATE, run_id FROM (
 SELECT CodeBarre, CAST(Dispo as INT64) as Dispo, CAST(quantity as INT64) as quantity, month,
  CASE WHEN month like '%Jan%' then CONCAT('{year}', '01') 
WHEN month like '%Fev%' then CONCAT('{year}', '02') 
WHEN month like '%Mar%' then CONCAT('{year}', '03') 
WHEN month like '%Avr%' then CONCAT('{year}', '04') 
WHEN month like '%Mai %' then CONCAT('{year}', '05') 
WHEN month like '%Juin%' then CONCAT('{year}', '06') 
WHEN month like '%Juil%' then CONCAT('{year}', '07') 
WHEN month like '%Aout%' then CONCAT('{year}', '08') 
WHEN month like '%Sept%' then CONCAT('{year}', '09') 
WHEN month like '%Oct%' then CONCAT('{year}', '10') 
WHEN month like '%Nov%' then CONCAT('{year}', '11')  
WHEN month like '%Dec%' then CONCAT('{year}', '12') end as periode, run_id
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_ppd_salsa_b`
UNPIVOT(quantity FOR month IN (Janv, Fev, Mar, Avr, Mai, Juin, Juil, Aout, Sept, Oct, Nov, Dec)) 
WHERE RUN_ID = '{run_id}'
 
) ) S
ON  D.PERIODE = S.PERIODE 
AND D.RUN_ID IS NULL
when  MATCHED then
update set
D.VOLUME	= 	S.quantity,
D.DISPO	= 	S.Dispo,
D.EAN	= 	S.CodeBarre,
D.UPDATE_DATETIME	= current_datetime()
when not MATCHED 
then
insert (EAN, DISPO, VOLUME, PERIODE,  INSERT_DATETIME, UPDATE_DATETIME, RETAILER, PERIOD_START_DATE, PERIOD_END_DATE, RUN_ID)
values (CodeBarre, Dispo, quantity, PERIODE, current_datetime(), current_datetime(), "COSMA PARFUMERIE", PERIOD_START_DATE, PERIOD_END_DATE, RUN_ID);