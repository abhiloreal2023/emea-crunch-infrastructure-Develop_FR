MERGE `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_lpd_powersante_b_o` D USING (
SELECT
   MARQUE,
   EAN,
   SUM(VOLUME) as VOLUME, 
   SUM(VALEUR) as VALEUR,
   FORMAT_DATE(
      '%Y%m%d', CAST(CAST(CONCAT(year, month, '01') AS DATE FORMAT 'YYYYMMDD') AS date)) AS PERIOD_START_DATE,
   FORMAT_DATE(
      '%Y%m%d',CAST(LAST_DAY(CAST(CONCAT(year, month, '01') AS DATE FORMAT 'YYYYMMDD'), MONTH) as date))  AS PERIOD_END_DATE,
   RUN_ID
FROM (
         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT RUN_ID,
                  MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_01 as valeur, Y_1_QTE_FACTUREE_01 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_01 <> "qte_facturee" or Y_1_QTE_FACTUREE_01 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_01 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_01, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_02 as valeur, Y_1_QTE_FACTUREE_02 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_02 <> "qte_facturee" OR Y_1_QTE_FACTUREE_02 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_02 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_02, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_03 as valeur, Y_1_QTE_FACTUREE_03 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_03 <> "qte_facturee" OR Y_1_QTE_FACTUREE_03 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_03 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_03, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_04 as valeur, Y_1_QTE_FACTUREE_04 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_04 <> "qte_facturee" OR Y_1_QTE_FACTUREE_04 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_04 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_04, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_05 as valeur, Y_1_QTE_FACTUREE_05 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_05 <> "qte_facturee" OR Y_1_QTE_FACTUREE_05 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_05 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_05, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_06 as valeur, Y_1_QTE_FACTUREE_06 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_06 <> "qte_facturee" OR Y_1_QTE_FACTUREE_06 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_06 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_06, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_07 as valeur, Y_1_QTE_FACTUREE_07 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_07 <> "qte_facturee" OR Y_1_QTE_FACTUREE_07 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_07 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_07, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%'AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_08 as valeur, Y_1_QTE_FACTUREE_08 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_08 <> "qte_facturee" OR Y_1_QTE_FACTUREE_08 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_08 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_08, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_09 as valeur, Y_1_QTE_FACTUREE_09 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_09 <> "qte_facturee" OR Y_1_QTE_FACTUREE_09 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_09 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_09, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')
         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_10 as valeur, Y_1_QTE_FACTUREE_10 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_10 <> "qte_facturee" OR Y_1_QTE_FACTUREE_10 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_10 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_10, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')
         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_11 as valeur, Y_1_QTE_FACTUREE_11 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_11 <> "qte_facturee" OR Y_1_QTE_FACTUREE_11 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_11 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_11, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_1_TOTAL_FACTURE_12 as valeur, Y_1_QTE_FACTUREE_12 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_1_QTE_FACTUREE_12 <> "qte_facturee" OR Y_1_QTE_FACTUREE_12 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_1_QTE_FACTUREE_12 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_1_QTE_FACTUREE_12, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_01 as valeur, Y_QTE_FACTUREE_01 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_01 <> "qte_facturee" OR Y_QTE_FACTUREE_01 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_01 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_01, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID,UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_02 as valeur, Y_QTE_FACTUREE_02 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_02 <> "qte_facturee" OR Y_QTE_FACTUREE_02 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_02 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_02, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_03 as valeur, Y_QTE_FACTUREE_03 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_03 <> "qte_facturee" OR Y_QTE_FACTUREE_03 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_03 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_03, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_04 as valeur, Y_QTE_FACTUREE_04 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_04 <> "qte_facturee" OR Y_QTE_FACTUREE_04 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_04 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_04, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_05 as valeur, Y_QTE_FACTUREE_05 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_05 <> "qte_facturee" OR Y_QTE_FACTUREE_05 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_05 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_05, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_06 as valeur, Y_QTE_FACTUREE_06 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_06 <> "qte_facturee" OR Y_QTE_FACTUREE_06 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_06 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_06, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_07 as valeur, Y_QTE_FACTUREE_07 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_07 <> "qte_facturee" OR Y_QTE_FACTUREE_07 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_07 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_07, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_08 as valeur, Y_QTE_FACTUREE_08 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_08 <> "qte_facturee" OR Y_QTE_FACTUREE_08 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_08 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_08, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_09 as valeur, Y_QTE_FACTUREE_09 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_09 <> "qte_facturee" OR Y_QTE_FACTUREE_09 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_09 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_09, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_10 as valeur, Y_QTE_FACTUREE_10 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_10 <> "qte_facturee" OR Y_QTE_FACTUREE_10 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_10 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_10, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_11 as valeur, Y_QTE_FACTUREE_11 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_11 <> "qte_facturee" OR Y_QTE_FACTUREE_11 is null) AND RUN_ID = '{run_id}'
            )
         cross join (
               select
                  Y_QTE_FACTUREE_11 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_11, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}') 

         UNION ALL 

         (SELECT RUN_ID, UPPER(MARQUE) as MARQUE, CAST(CAST(EAN as NUMERIC) AS STRING) as EAN,  
            CAST(REPLACE(valeur, ' €', '') as NUMERIC) as VALEUR, 
            CAST(volume as NUMERIC) as VOLUME, CAST(LEFT(PERIODE, 4) as INTEGER) as year, RIGHT(PERIODE, 2) as month
         from (
               SELECT
                  RUN_ID, MARQUE, 
                  ean as EAN, Y_TOTAL_FACTURE_12 as valeur, Y_QTE_FACTUREE_12 as volume
                  FROM `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o` 
               where (Y_QTE_FACTUREE_12 <> "qte_facturee" OR Y_QTE_FACTUREE_12 is null) AND RUN_ID = '{run_id}' 
            )
         cross join (
               select
                  Y_QTE_FACTUREE_12 as PERIODE 
               from `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_powersante_b_o`
               where REGEXP_EXTRACT(Y_QTE_FACTUREE_12, r'[0-9]{{6}}') is not null
               ) 
         where UPPER(MARQUE) LIKE '%BIOTHERM%' AND RUN_ID = '{run_id}')

)
GROUP BY
   MARQUE,
   RUN_ID, 
   EAN,
   PERIOD_START_DATE,
   PERIOD_END_DATE
) S ON D.EAN = S.EAN 
AND D.PERIOD_START_DATE = S.PERIOD_START_DATE
AND D.RUN_ID IS NULL when MATCHED then 
update 
set 
   D.VALEUR = S.VALEUR, 
   D.VOLUME = S.VOLUME, 
   D.UPDATE_DATETIME = current_datetime() when not MATCHED 
      then insert (
      MARQUE, EAN,VALEUR, VOLUME, 
      INSERT_DATETIME, UPDATE_DATETIME, 
      RETAILER, PERIOD_START_DATE, PERIOD_END_DATE, 
      RUN_ID
   ) 
values 
(
   
   MARQUE, 
   EAN,
   VALEUR, 
   VOLUME,
   current_datetime(), 
   current_datetime(), 
      'POWER SANTE',
   PERIOD_START_DATE, 
   PERIOD_END_DATE, 
   RUN_ID
);
