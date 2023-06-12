insert into `emea-crunch-gbl-emea-{env}.d_crunch_fr_dom_{env}.t_lpd_tendanceparfums_o`
WITH
  curr_year AS(
  SELECT
    DISTINCT REPLACE(valeur,'.0','') AS current_year
  FROM
    `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_tendanceparfums_o` UNPIVOT(VALEUR FOR PERIODE_MOIS IN ( `so_tcc_n`,
        `so_tcc_n-1`))
  WHERE
    RUN_ID = '{run_id}'
    AND periode_mois LIKE '%_n'
    AND month IS NULL ),
  prev_year AS(
  SELECT
    DISTINCT REPLACE(valeur,'.0','') AS previous_year
  FROM
    `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_tendanceparfums_o` UNPIVOT(VALEUR FOR PERIODE_MOIS IN ( `so_tcc_n`,
        `so_tcc_n-1`))
  WHERE
    RUN_ID = '{run_id}'
    AND periode_mois LIKE '%_n-1'
    AND month IS NULL )

SELECT
  loreal_market_flag,
  cast(period_start_date as int64) period_start_date,
  cast(period_end_date as int64) period_end_date,
  amount,
  CASE
    WHEN TRIM(brand) = 'so_tcc' THEN ''
  ELSE
  upper(case when brand='viktor&rolf' then 'viktor & rolf' else brand end)
END
  AS brand,
  '{run_id}' as run_id
FROM (
  SELECT
    'L' AS loreal_market_flag,
    FORMAT_DATE('%Y%m%d', CAST( CONCAT( SUBSTR(periode, 1, 4), '-', SUBSTR(periode, 5, 6), '-', '01') AS DATE )) AS PERIOD_START_DATE,
    FORMAT_DATE('%Y%m%d', DATE_SUB(DATE_TRUNC(DATE_ADD(CAST( CONCAT( SUBSTR(periode, 1, 4), '-', SUBSTR(periode, 5, 6), '-', '01') AS DATE ), INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)) AS PERIOD_END_DATE,
    amount,
    brand
  FROM (
    SELECT
      (CASE
          WHEN UPPER(month) = 'JANV' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'01')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'01')
      END
      END
          WHEN UPPER(month) = 'FÉVR' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'02')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'02')
      END
      END
          WHEN UPPER(month) = 'MARS' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'03')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'03')
      END
      END
          WHEN UPPER(month) = 'AVR' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'04')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'04')
      END
      END
          WHEN UPPER(month) = 'MAI' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'05')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'05')
      END
      END
          WHEN UPPER(month) = 'JUIN' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'06')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'06')
      END
      END
          WHEN UPPER(month) = 'JUIL' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'07')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'07')
      END
      END
          WHEN UPPER(month) = 'AOÛT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'08')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'08')
      END
      END
          WHEN UPPER(month) = 'SEPT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'09')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'09')
      END
      END
          WHEN UPPER(month) = 'OCT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'10')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'10')
      END
      END
          WHEN UPPER(month) = 'NOV' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'11')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'11')
      END
      END
          WHEN UPPER(month) = 'DEC' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'12')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'12')
      END
      END
      END
        ) AS periode,
      CASE
        WHEN periode_mois LIKE '%_n-1' THEN (CAST(valeur AS numeric)* CAST(`so_tcc_n-1` AS numeric)/100)
      ELSE
      CASE
        WHEN periode_mois LIKE '%_n' THEN (CAST(valeur AS numeric)* CAST(so_tcc_n AS numeric)/100)
    END
    END
      amount,
      REPLACE(replace(periode_mois,
          '_n-1',
          ''),'_n','') AS brand
    FROM
      `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_tendanceparfums_o` UNPIVOT(VALEUR FOR PERIODE_MOIS IN ( `ysl_n-1`,
          `ysl_n`,
          `lancome_n-1`,
          `lancome_n`,
          `armani_n-1`,
          `armani_n`,
          `mugler_n-1`,
          `mugler_n`,
          `azzaro_n-1`,
          `azzaro_n`,
          `cacharel_n-1`,
          `cacharel_n`,
          `diesel_n-1`,
          `diesel_n`,
          `viktor&rolf_n-1`,
          `viktor&rolf_n`,
          `prada_n-1`,
          `prada_n`,
          `valentino_n-1`,
          `valentino_n`,
          `lauren_n-1`,
          `lauren_n`,
          `biotherm_n-1`,
          `biotherm_n`))
    CROSS JOIN
      curr_year
    CROSS JOIN
      prev_year
    WHERE
      RUN_ID = '{run_id}'
      AND month IS NOT NULL
      AND TRIM(month) <>'TOTAL' )
  UNION ALL
  SELECT
    'M' AS loreal_market_flag,
    FORMAT_DATE('%Y%m%d', CAST( CONCAT( SUBSTR(periode, 1, 4), '-', SUBSTR(periode, 5, 6), '-', '01') AS DATE )) AS PERIOD_START_DATE,
    FORMAT_DATE('%Y%m%d', DATE_SUB(DATE_TRUNC(DATE_ADD(CAST( CONCAT( SUBSTR(periode, 1, 4), '-', SUBSTR(periode, 5, 6), '-', '01') AS DATE ), INTERVAL 1 MONTH), MONTH), INTERVAL 1 DAY)) AS PERIOD_END_DATE,
    amount,
    brand
  FROM (
    SELECT
      (CASE
          WHEN UPPER(month) = 'JANV' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'01')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'01')
      END
      END
          WHEN UPPER(month) = 'FÉVR' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'02')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'02')
      END
      END
          WHEN UPPER(month) = 'MARS' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'03')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'03')
      END
      END
          WHEN UPPER(month) = 'AVR' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'04')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'04')
      END
      END
          WHEN UPPER(month) = 'MAI' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'05')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'05')
      END
      END
          WHEN UPPER(month) = 'JUIN' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'06')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'06')
      END
      END
          WHEN UPPER(month) = 'JUIL' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'07')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'07')
      END
      END
          WHEN UPPER(month) = 'AOÛT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'08')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'08')
      END
      END
          WHEN UPPER(month) = 'SEPT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'09')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'09')
      END
      END
          WHEN UPPER(month) = 'OCT' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'10')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'10')
      END
      END
          WHEN UPPER(month) = 'NOV' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'11')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'11')
      END
      END
          WHEN UPPER(month) = 'DEC' THEN CASE
          WHEN PERIODE_MOIS LIKE '%_n' THEN CONCAT(current_year,'12')
        ELSE
        CASE
          WHEN PERIODE_MOIS LIKE '%_n-1' THEN CONCAT(previous_year,'12')
      END
      END
      END
        ) AS periode,
      CAST(VALEUR AS numeric) AS amount,
      REPLACE(replace(periode_mois,
          '_n-1',
          ''),'_n','') AS brand
    FROM
      `emea-crunch-gbl-emea-{env}.d_crunch_fr_stg_{env}.t_lpd_tendanceparfums_o` UNPIVOT(VALEUR FOR PERIODE_MOIS IN ( `so_tcc_n`,
          `so_tcc_n-1`))
    CROSS JOIN
      curr_year
    CROSS JOIN
      prev_year
    WHERE
      RUN_ID = '{run_id}'
      AND month IS NOT NULL
      AND TRIM(month) <>'TOTAL' ) )