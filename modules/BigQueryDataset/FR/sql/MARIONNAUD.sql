Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
Set BRAND = '{brand}'
where  BRAND is null AND RUN_ID = '{run_id}';

Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
Set MARQUE = 'LA ROCHE-POSAY'
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   UPPER(MARQUE) Like '%LRP%';

Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
Set MARQUE = 'LA ROCHE-POSAY'
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   UPPER(MARQUE) Like '%LA ROCHE POSAY%';

--Truncate table emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_marionnaud_o;

MERGE  emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_marionnaud_o D
USING (
Select RUN_ID, PERIODE, VALEUR, VOLUME, MARQUE,  FORMAT_DATE('%Y%m%d', CAST( CONCAT(
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
          ), INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)) AS PERIOD_END_DATE from (
            SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_01 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_01 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_01,  Y_1_Ventes_Volume_01, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_01 is not null)
cross join (select distinct Y_1_Ventes_01 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_01 is null and REGEXP_EXTRACT(Y_1_Ventes_01, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_01 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_01 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_01,  Y_Ventes_Volume_01, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_01 is not null)
cross join (select distinct Y_Ventes_01 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_01 is null and REGEXP_EXTRACT(Y_Ventes_01, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_01 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_01 is null and REGEXP_EXTRACT(Y_1_Ventes_01, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_02 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_02 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_02,  Y_1_Ventes_Volume_02, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_02 is not null)
cross join (select distinct Y_1_Ventes_02 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_02 is null and REGEXP_EXTRACT(Y_1_Ventes_02, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_02 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_02 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_02,  Y_Ventes_Volume_02, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_02 is not null)
cross join (select distinct Y_Ventes_02 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_02 is null and REGEXP_EXTRACT(Y_Ventes_02, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_02 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_02 is null and REGEXP_EXTRACT(Y_1_Ventes_02, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_03 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_03 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_03,  Y_1_Ventes_Volume_03, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_03 is not null)
cross join (select distinct Y_1_Ventes_03 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_03 is null and REGEXP_EXTRACT(Y_1_Ventes_03, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_03 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_03 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_03,  Y_Ventes_Volume_03, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_03 is not null)
cross join (select distinct Y_Ventes_03 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_03 is null and REGEXP_EXTRACT(Y_Ventes_03, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_03 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_03 is null and REGEXP_EXTRACT(Y_1_Ventes_03, r'^(10|1*[1-9]{{1}})$') is not null)


UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_04 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_04 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_04,  Y_1_Ventes_Volume_04, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_04 is not null)
cross join (select distinct Y_1_Ventes_04 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_04 is null and REGEXP_EXTRACT(Y_1_Ventes_04, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_04 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_04 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_04,  Y_Ventes_Volume_04, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_04 is not null)
cross join (select distinct Y_Ventes_04 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_04 is null and REGEXP_EXTRACT(Y_Ventes_04, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_04 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_04 is null and REGEXP_EXTRACT(Y_1_Ventes_04, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_05 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_05 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_05,  Y_1_Ventes_Volume_05, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_05 is not null)
cross join (select distinct Y_1_Ventes_05 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_05 is null and REGEXP_EXTRACT(Y_1_Ventes_05, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_05 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_05 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_05,  Y_Ventes_Volume_05, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_05 is not null)
cross join (select distinct Y_Ventes_05 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_05 is null and REGEXP_EXTRACT(Y_Ventes_05, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_05 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_05 is null and REGEXP_EXTRACT(Y_1_Ventes_05, r'^(10|1*[1-9]{{1}})$') is not null)


UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_06 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_06 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_06,  Y_1_Ventes_Volume_06, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET'and Y_1_Ventes_Volume_06 is not null)
cross join (select distinct Y_1_Ventes_06 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_06 is null and REGEXP_EXTRACT(Y_1_Ventes_06, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_06 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_06 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_06,  Y_Ventes_Volume_06, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_06 is not null)
cross join (select distinct Y_Ventes_06 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_06 is null and REGEXP_EXTRACT(Y_Ventes_06, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_06 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_06 is null and REGEXP_EXTRACT(Y_1_Ventes_06, r'^(10|1*[1-9]{{1}})$') is not null)


UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_07 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_07 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_07,  Y_1_Ventes_Volume_07, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_07 is not null)
cross join (select distinct Y_1_Ventes_07 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_07 is null and REGEXP_EXTRACT(Y_1_Ventes_07, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_07 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_07 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_07,  Y_Ventes_Volume_07, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_07 is not null)
cross join (select distinct Y_Ventes_07 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_07 is null and REGEXP_EXTRACT(Y_Ventes_07, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_07 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_07 is null and REGEXP_EXTRACT(Y_1_Ventes_07, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_08 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_08 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_08,  Y_1_Ventes_Volume_08, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_08 is not null)
cross join (select distinct Y_1_Ventes_08 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_08 is null and REGEXP_EXTRACT(Y_1_Ventes_08, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_08 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_08 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_08,  Y_Ventes_Volume_08, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_08 is not null)
cross join (select distinct Y_Ventes_08 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_08 is null and REGEXP_EXTRACT(Y_Ventes_08, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_08 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_08 is null and REGEXP_EXTRACT(Y_1_Ventes_08, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_09 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_09 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_09,  Y_1_Ventes_Volume_09, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_09 is not null)
cross join (select distinct Y_1_Ventes_09 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_09 is null and REGEXP_EXTRACT(Y_1_Ventes_09, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_09 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_09 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_09,  Y_Ventes_Volume_09, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_09 is not null)
cross join (select distinct Y_Ventes_09 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_09 is null and REGEXP_EXTRACT(Y_Ventes_09, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_09 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_09 is null and REGEXP_EXTRACT(Y_1_Ventes_09, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_10 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_10 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_10,  Y_1_Ventes_Volume_10, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_10 is not null)
cross join (select distinct Y_1_Ventes_10 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_10 is null and REGEXP_EXTRACT(Y_1_Ventes_10, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_10 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_10 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_10,  Y_Ventes_Volume_10, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_10 is not null)
cross join (select distinct Y_Ventes_10 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_10 is null and REGEXP_EXTRACT(Y_Ventes_10, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_10 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_10 is null and REGEXP_EXTRACT(Y_1_Ventes_10, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_11 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_11 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_11,  Y_1_Ventes_Volume_11, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_1_Ventes_Volume_11 is not null)
cross join (select distinct Y_1_Ventes_11 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_11 is null and REGEXP_EXTRACT(Y_1_Ventes_11, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_11 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_11 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_11,  Y_Ventes_Volume_11, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_11 is not null)
cross join (select distinct Y_Ventes_11 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_11 is null and REGEXP_EXTRACT(Y_Ventes_11, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_11 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_11 is null and REGEXP_EXTRACT(Y_1_Ventes_11, r'^(10|1*[1-9]{{1}})$') is not null)

UNION ALL

SELECT CONCAT(YEAR, FORMAT("%02d", CAST(MONTH as INT64))) as PERIODE, VALEUR, VOLUME, RUN_ID FROM (
Select CAST(Y_1_Ventes_12 as FLOAT64) as VALEUR , CAST(Y_1_Ventes_Volume_12 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_1_Ventes_12,  Y_1_Ventes_Volume_12, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' AND  Y_1_Ventes_Volume_12 is not null)
cross join (select distinct Y_1_Ventes_12 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_1_Ventes_Volume_12 is null and REGEXP_EXTRACT(Y_1_Ventes_12, r'^[0-9]{{4}}$') is not null)
UNION ALL
Select CAST(Y_Ventes_12 as FLOAT64) as VALEUR , CAST(Y_Ventes_Volume_12 as INT64) as VOLUME , YEAR, RUN_ID
from
(select Y_Ventes_12,  Y_Ventes_Volume_12, RUN_ID
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   MAGASIN = 'INTERNET' and Y_Ventes_Volume_12 is not null)
cross join (select distinct Y_Ventes_12 as YEAR from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_12 is null and REGEXP_EXTRACT(Y_Ventes_12, r'^[0-9]{{4}}$') is not null))
Cross join (Select Y_1_Ventes_12 as MONTH
from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   Y_Ventes_Volume_12 is null and REGEXP_EXTRACT(Y_1_Ventes_12, r'^(10|1*[1-9]{{1}})$') is not null))
cross join (Select Marque as MARQUE
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND   REGEXP_EXTRACT(MARQUE, r'^[a-zA-Z][a-zA-Z]*') is not null)

) S
ON D.PERIODE=S.PERIODE 
AND D.MARQUE=S.MARQUE
AND D.RUN_ID IS NULL
when  MATCHED then
update set
D.VALEUR	= 	S.VALEUR,
D.VOLUME	= 	S.VOLUME,
D.UPDATE_DATETIME	= current_datetime()
when not MATCHED then
insert (MARQUE, EAN,DESIGNATION, VALEUR, VOLUME,PERIODE,  INSERT_DATETIME, UPDATE_DATETIME, RETAILER, PERIOD_START_DATE, PERIOD_END_DATE, RUN_ID)
values (MARQUE, Null,Null, VALEUR, VOLUME, PERIODE,current_datetime(), current_datetime(), "MARIONNAUD",  PERIOD_START_DATE, PERIOD_END_DATE, RUN_ID);

--Truncate table emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_marionnaud_o;