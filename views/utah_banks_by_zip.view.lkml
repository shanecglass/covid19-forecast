view: utah_banks_by_zip {
    derived_table: {
      sql: with utah_fips AS
  (SELECT
    state_fips_code
   FROM
    `bigquery-public-data.census_utility.fips_codes_states`
   WHERE
    state_name = "Utah")

,utah_zip AS
  (SELECT
    z.zip_code,
    z.zip_code_geom,
  FROM
  `bigquery-public-data.geo_us_boundaries.zip_codes` z
  ,utah_fips u
    WHERE
      z.state_fips_code = u.state_fips_code)

,locations AS
  (SELECT
  COUNT(i.institution_name) AS count_locations
  ,l.zip_code
FROM
  `cloud-public-datasets-demos.retail_banking_demo.fdic_institutions` i
JOIN
  `cloud-public-datasets-demos.retail_banking_demo.fdic_locations` l USING (fdic_certificate_number)
WHERE
  l.state IS NOT NULL
  AND l.state_name IS NOT NULL
GROUP BY
  2)

SELECT
  SUM(l.count_locations) AS locations_per_zip
  ,z.zip_code
FROM
  utah_zip z
JOIN
  locations l USING (zip_code)
GROUP BY
  z.zip_code
ORDER BY
  locations_per_zip desc;;
   }

# Define your dimensions and measures here, like this:
  dimension: zip_code {
     description: "Zip code associated with the ZCTA that contains the bank branches"
     type: zipcode
     sql: ${TABLE}.zip_code;;
   }

   dimension: locations_per_zip{
     description: "The total number of bank branches for each ZCTA"
     type: number
     sql: ${TABLE}.locations_per_zip ;;
   }
}
