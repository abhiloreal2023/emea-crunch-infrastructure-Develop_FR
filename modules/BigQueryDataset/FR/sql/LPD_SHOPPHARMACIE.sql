MERGE `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_lpd_shoppharmacie_o` D USING (
SELECT 
  Product_ID, 
  DESIGNATION, 
  PRIX_VENTE, 
  LITRAGE,
  PERIODE, 
  Sum(VOLUME) as VOLUME, 
  SUM(VALEUR) as VALEUR, 
  FORMAT_DATE(
    '%Y%m%d', 
    CAST(
      CONCAT(
        SUBSTR(periode, 1, 4), 
        '-', 
        SUBSTR(periode, 5, 6), 
        '-', 
        '01'
      ) AS DATE
    )
  ) AS PERIOD_START_DATE, 
  FORMAT_DATE(
    '%Y%m%d', 
    DATE_SUB(
      DATE_TRUNC(
        DATE_ADD(
          CAST(
            CONCAT(
              SUBSTR(periode, 1, 4), 
              '-', 
              SUBSTR(periode, 5, 6), 
              '-', 
              '01'
            ) AS DATE
          ), 
          INTERVAL 1 MONTH
        ), 
        MONTH
      ), 
      INTERVAL 1 DAY
    )
  ) AS PERIOD_END_DATE, 
  RUN_ID 
FROM (
      SELECT 
        Product_ID, 
        Product_Name as DESIGNATION,        
        SKU as LITRAGE,
        CAST(trim(replace(replace(ApoEK, '€' ,""), ',', '.')) as FLOAT64) as PRIX_VENTE,
        CAST(REGEXP_EXTRACT(VOLUME, r"[0-9]+$") AS INT64) as VOLUME,
        SAFE_MULTIPLY(
          CAST(REGEXP_EXTRACT(VOLUME, r"[0-9]+$") AS INT64), CAST(trim(replace(replace(ApoEK, '€' ,""), ',', '.')) as FLOAT64) 
        ) as VALEUR, 
        
        CASE WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'JANVIER_quantity') is True then CONCAT('{year}', '01') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'FEVRIER_quantity') is True then CONCAT('{year}', '02')
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'MARS_quantity') is True then CONCAT('{year}', '03') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'AVRIL_quantity') is True then CONCAT('{year}', '04') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'MAI_quantity') is True then CONCAT('{year}', '05') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'JUIN_quantity') is True then CONCAT('{year}', '06') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'JUILLET_quantity') is True then CONCAT('{year}', '07') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'AOUT_quantity') is True then CONCAT('{year}', '08') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'SEPTEMBRE_quantity') is True then CONCAT('{year}', '09') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'OCTOBRE_quantity') is True then CONCAT('{year}', '10') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'NOVEMBRE_quantity') is True then CONCAT('{year}', '11') 
              WHEN REGEXP_CONTAINS(PERIODE_MOIS, r'DECEMBRE_quantity') is True then CONCAT('{year}', '12') ELSE NULL END PERIODE,
        RUN_ID 
      FROM 
          `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_shoppharmacie_o`
          UNPIVOT(
              VOLUME FOR PERIODE_MOIS IN (
                JANVIER_quantity, FEVRIER_quantity, 
                MARS_quantity, AVRIL_quantity, MAI_quantity, 
                JUIN_quantity, JUILLET_quantity, 
                AOUT_quantity, SEPTEMBRE_quantity, 
                OCTOBRE_quantity, NOVEMBRE_quantity, 
                DECEMBRE_quantity
              )
          )
      WHERE 
        Product_Name is not null 
        and VOLUME != '0' 
        and ApoEK != '€'
        and lower(ApoEK) != 'apoek'
        and lower(Product_Name) != 'product name'    
        AND RUN_ID = '{run_id}'  
)
GROUP BY 
  RUN_ID, 
  Product_ID, 
  DESIGNATION, 
  PRIX_VENTE, 
  LITRAGE,
  PERIODE
   ) S ON D.Product_ID = S.Product_ID 
AND D.PERIODE = S.PERIODE
AND D.DESIGNATION = S.DESIGNATION 
AND D.RUN_ID IS NULL when MATCHED then 
update 
set 
  D.VALEUR = S.VALEUR, 
  D.VOLUME = S.VOLUME, 
  D.PRIX_VENTE = S.PRIX_VENTE, 
  D.LITRAGE = S.LITRAGE, 
  D.UPDATE_DATETIME = current_datetime() when not MATCHED 
  AND DESIGNATION is not null 
  AND VOLUME != 0.0 
  and VOLUME is not null then insert (
    Product_ID, DESIGNATION, LITRAGE, 
    PRIX_VENTE, VALEUR, VOLUME, PERIODE, 
    INSERT_DATETIME, UPDATE_DATETIME, 
    RETAILER, PERIOD_START_DATE, PERIOD_END_DATE, 
    RUN_ID
  ) 
values 
  (
   
    Product_ID, 
    DESIGNATION, 
    LITRAGE, 
    PRIX_VENTE, 
    VALEUR, 
    VOLUME, 
    PERIODE, 
    current_datetime(), 
    current_datetime(), 
    "SHOP PHARMACIE", 
    PERIOD_START_DATE, 
    PERIOD_END_DATE, 
    RUN_ID
  );

  