Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
Set BRAND = '{brand}'
where  BRAND is null AND RUN_ID = '{run_id}';

MERGE  emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o D
USING  (
 select MARQUE, EAN, NOM_PRODUIT, 
 VALEUR,  VOLUME, PERIODE
 ,
FORMAT_DATE('%Y%m%d', CAST( CONCAT(
              SUBSTR(periode, 1 , 4),
              '-' ,
              SUBSTR(periode, 5 , 6),
              '-' ,
              '01')
             AS DATE
          )) AS PERIOD_START_DATE,
         FORMAT_DATE('%Y%m%d',  DATE_SUB(DATE_TRUNC(DATE_ADD(CAST(
            CONCAT(
              SUBSTR(periode, 1 , 4),
              '-' ,
              SUBSTR(periode, 5 , 6),
              '-' ,
              '01')
             AS DATE
          ), INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)) AS PERIOD_END_DATE
 
 from ((SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (
    SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_4 as valeur, string_field_3 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_3) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_3 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_3, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_6 as valeur, string_field_5 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_5) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_5 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_5, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_8 as valeur, string_field_7 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_7) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_7 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_7, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_10 as valeur, string_field_9 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_9) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_9 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_9, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_12 as valeur, string_field_11 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_11) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_11 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_11, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_14 as valeur, string_field_13 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_13) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_13 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_13, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_16 as valeur, string_field_15 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_15) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_15 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_15, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_18 as valeur, string_field_17 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_17) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_17 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_17, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  ( SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_20 as valeur, string_field_19 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_19) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_19 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_19, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_22 as valeur, string_field_21 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_21) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_21 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_21, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  ( SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_24 as valeur, string_field_23 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_23) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_23 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_23, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_26 as valeur, string_field_25 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_25) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_25 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_25, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_28 as valeur, string_field_27 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_27) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_27 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_27, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_30 as valeur, string_field_29 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_29) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_29 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_29, r'[0-9]{{6}}') is not null))


UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_32 as valeur, string_field_31 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_31) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_31 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_31, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  ( SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_34 as valeur, string_field_33 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_33) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_33 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_33, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_36 as valeur, string_field_35 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_35) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_35 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_35, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_38 as valeur, string_field_37 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_37) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_37 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_37, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_40 as valeur, string_field_39 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_39) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_39 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_39, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_42 as valeur, string_field_41 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_41) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_41 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_41, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  ( SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_44 as valeur, string_field_43 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_43) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_43 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_43, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from   (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_46 as valeur, string_field_45 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_45) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_45 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_45, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_48 as valeur, string_field_47 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_47) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_47 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_47, r'[0-9]{{6}}') is not null))

UNION ALL 

(SELECT UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN, NOM_PRODUIT, 
CAST(REPLACE(valeur, ' €', '') as Float64) as VALEUR, 
CAST(volume as Float64) as VOLUME, PERIODE
 from  (SELECT string_field_0 as MARQUE, string_field_1 as NOM_PRODUIT,
string_field_2 as EAN, string_field_50 as valeur, string_field_49 as volume
FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o` 
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  upper(string_field_49) <> "QTE_FACTUREE" and string_field_2 is not null)
cross join (select string_field_49 as PERIODE from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_acd_boticinal_o`
where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  REGEXP_EXTRACT(string_field_49, r'[0-9]{{6}}') is not null))


)) S
ON D.EAN=S.EAN AND D.PERIODE=S.PERIODE AND D.MARQUE=S.MARQUE AND D.NOM_PRODUIT	= 	S.NOM_PRODUIT
when  MATCHED then
update set 
D.VALEUR	= 	S.VALEUR,
D.VOLUME	= 	CAST(S.VOLUME as INT64) ,
D.PRIX_VENTE = SAFE_DIVIDE(S.VALEUR, S.VOLUME),
D.UPDATE_DATETIME	= current_datetime()
when not MATCHED and S.NOM_PRODUIT is not null and S.MARQUE <> 'Total' and S.VOLUME is not null then
insert (MARQUE, EAN, NOM_PRODUIT, PRIX_VENTE, VALEUR, VOLUME, PERIODE, INSERT_DATETIME, UPDATE_DATETIME, RETAILER, PERIOD_START_DATE, PERIOD_END_DATE, RUN_ID)
values (MARQUE, EAN, NOM_PRODUIT,SAFE_DIVIDE(VALEUR, VOLUME), VALEUR, CAST(VOLUME as INT64), PERIODE, current_datetime(), current_datetime(), "BOTICINAL", PERIOD_START_DATE, PERIOD_END_DATE, '{run_id}');


-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'VICHY'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%VICHY%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'LA ROCHE-POSAY'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%LRP%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'LA ROCHE-POSAY'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%LA ROCHE POSAY%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'DECLEOR'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%DECL?OR%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'DECLEOR'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%DECLÉOR%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'CERAVE'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%CERAVE%';

-- Update `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_acd_boticinal_o`
-- Set MARQUE = 'VICHY'
-- where BRAND = '{brand}' AND RUN_ID = '{run_id}' AND  UPPER(MARQUE) Like '%DERCOS%';