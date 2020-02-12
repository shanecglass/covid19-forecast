view: utah_acs_changes_2011_2017 {
# Or, you could make this view a derived table, like this:
derived_table: {
  sql:
    WITH
      utah_fips AS (
      SELECT
        state_fips_code
      FROM
        `bigquery-public-data.census_utility.fips_codes_states`
      WHERE
        state_name = "Utah"),

      utah_zip AS (
      SELECT
        z.zip_code,
        z.zip_code_geom,
      FROM
        `bigquery-public-data.geo_us_boundaries.zip_codes` z,
        utah_fips u
      WHERE
        z.state_fips_code = u.state_fips_code)

    ,acs_2011 AS (
      SELECT
        geo_id,
        total_pop,
        median_age,
        households,
        income_per_capita,
        housing_units,
        vacant_housing_units_for_sale,
        owner_occupied_housing_units_lower_value_quartile,
        owner_occupied_housing_units_median_value,
        owner_occupied_housing_units_upper_value_quartile,
        income_200000_or_more,
        income_150000_199999,
        income_125000_149999,
        income_100000_124999,
        income_75000_99999,
        income_60000_74999,
        income_50000_59999,
        income_45000_49999,
        income_40000_44999,
        income_35000_39999,
        income_30000_34999,
        income_25000_29999,
        income_20000_24999,
        income_15000_19999,
        income_10000_14999,
        income_less_10000,
        employed_pop,
        bachelors_degree_or_higher_25_64
      FROM
        `bigquery-public-data.census_bureau_acs.zip_codes_2011_5yr`
      JOIN
        utah_zip ON zip_code = geo_id)

    -- SELECT
    --   *
    -- FROM
    --   acs_2011

    ,acs_2017 AS (
      SELECT
        geo_id,
        total_pop,
        median_age,
        households,
        income_per_capita,
        housing_units,
        vacant_housing_units_for_sale,
        owner_occupied_housing_units_lower_value_quartile,
        owner_occupied_housing_units_median_value,
        owner_occupied_housing_units_upper_value_quartile,
        income_200000_or_more,
        income_150000_199999,
        income_125000_149999,
        income_100000_124999,
        income_75000_99999,
        income_60000_74999,
        income_50000_59999,
        income_45000_49999,
        income_40000_44999,
        income_35000_39999,
        income_30000_34999,
        income_25000_29999,
        income_20000_24999,
        income_15000_19999,
        income_10000_14999,
        income_less_10000,
        employed_pop,
        bachelors_degree_or_higher_25_64
      FROM
        `bigquery-public-data.census_bureau_acs.zip_codes_2017_5yr`
      JOIN
        utah_zip ON zip_code = geo_id
      )

    -- SELECT
    --   *
    -- FROM
    --   acs_2017

    ,acs_diff AS(
      SELECT
        acs17.geo_id,
        ROUND(SAFE_SUBTRACT(acs17.total_pop, acs11.total_pop), 2) AS diff_total_pop,
        ROUND(SAFE_SUBTRACT(acs17.median_age, acs11.median_age), 2) AS diff_median_age,
        ROUND(SAFE_SUBTRACT(acs17.households, acs11.households), 2) AS diff_households,
        ROUND(SAFE_SUBTRACT(acs17.income_per_capita, acs11.income_per_capita), 2) AS diff_income_per_capita,
        ROUND(SAFE_SUBTRACT(acs17.housing_units, acs11.housing_units), 2) AS diff_housing_units,
        ROUND(SAFE_SUBTRACT(acs17.vacant_housing_units_for_sale, acs11.vacant_housing_units_for_sale), 2) AS diff_vacant_housing_units_for_sale,
        ROUND(SAFE_SUBTRACT(acs17. owner_occupied_housing_units_lower_value_quartile , acs11.owner_occupied_housing_units_lower_value_quartile), 2) AS diff_owner_occupied_housing_units_lower_value_quartile,
        ROUND(SAFE_SUBTRACT(acs17. owner_occupied_housing_units_median_value , acs11.owner_occupied_housing_units_median_value), 2) AS diff_owner_occupied_housing_units_median_value,
        ROUND(SAFE_SUBTRACT(acs17. owner_occupied_housing_units_upper_value_quartile , acs11.owner_occupied_housing_units_upper_value_quartile), 2) AS owner_occupied_housing_units_upper_value_quartile,
        ROUND(SAFE_SUBTRACT(acs17.income_200000_or_more, acs11.income_200000_or_more), 2) AS diff_income_200000_or_more,
        ROUND(SAFE_SUBTRACT(acs17.income_150000_199999, acs11.income_150000_199999), 2) AS diff_income_150000_199999,
        ROUND(SAFE_SUBTRACT(acs17.income_125000_149999, acs11.income_125000_149999), 2) AS diff_income_125000_149999,
        ROUND(SAFE_SUBTRACT(acs17.income_100000_124999, acs11.income_100000_124999), 2) AS diff_income_100000_124999,
        ROUND(SAFE_SUBTRACT(acs17.income_75000_99999, acs11.income_75000_99999), 2) AS diff_income_75000_99999,
        ROUND(SAFE_SUBTRACT(acs17.income_60000_74999, acs11.income_60000_74999), 2) AS diff_income_60000_74999,
        ROUND(SAFE_SUBTRACT(acs17.income_50000_59999, acs11.income_50000_59999), 2) AS diff_income_50000_59999,
        ROUND(SAFE_SUBTRACT(acs17.income_45000_49999, acs11.income_45000_49999), 2) AS diff_income_45000_49999,
        ROUND(SAFE_SUBTRACT(acs17.income_40000_44999, acs11.income_40000_44999), 2) AS diff_income_40000_44999,
        ROUND(SAFE_SUBTRACT(acs17.income_35000_39999, acs11.income_35000_39999), 2) AS diff_income_35000_39999,
        ROUND(SAFE_SUBTRACT(acs17.income_30000_34999, acs11.income_30000_34999), 2) AS diff_income_30000_34999,
        ROUND(SAFE_SUBTRACT(acs17.income_25000_29999, acs11.income_25000_29999), 2) AS diff_income_25000_29999,
        ROUND(SAFE_SUBTRACT(acs17.income_20000_24999, acs11.income_20000_24999), 2) AS diff_income_20000_24999,
        ROUND(SAFE_SUBTRACT(acs17.income_15000_19999, acs11.income_15000_19999), 2) AS diff_income_15000_19999,
        ROUND(SAFE_SUBTRACT(acs17.income_10000_14999, acs11.income_10000_14999), 2) AS diff_income_10000_14999,
        ROUND(SAFE_SUBTRACT(acs17.income_less_10000, acs11.income_less_10000), 2) AS diff_income_less_10000,
        ROUND(SAFE_SUBTRACT(acs17.employed_pop, acs11.employed_pop), 2) AS diff_employed_pop,
        ROUND(SAFE_SUBTRACT(acs17.bachelors_degree_or_higher_25_64, acs11.bachelors_degree_or_higher_25_64), 2) AS diff_bachelors_degree_or_higher_25_64
      FROM
        acs_2017 acs17
      JOIN
        utah_zip ON zip_code = acs17.geo_id
      LEFT JOIN
        acs_2011 acs11 USING (geo_id)
      )

    SELECT
      *
    FROM
      acs_diff

     ;;
}

# Define your dimensions and measures here, like this:

dimension: Zip_Code{
  description: "The 5 digit zip code associated with the ZCTA."
  type: zipcode
  sql: ${TABLE}.diff_total_pop;;
}

dimension: Population {
  description: "Total Population. The total number of all people living in a given geographic area. This is a very useful catch-all denominator when calculating rates."
  type: number
  sql: ${TABLE}.diff_total_pop ;;
}

dimension: Median_Age {
  description: "Median Age. The median age of all people in a given geographic area."
  type: number
  sql: ${TABLE}.diff_median_age ;;
}

dimension: Income_Per_Capita {
  description: "Per Capita Income in the past 12 Months. Per capita income is the mean income computed for every man, woman, and child in a particular group. It is derived by dividing the total income of a particular group by the total population."
  type: number
  sql: ${TABLE}.diff_income_per_capita ;;
}

dimension: Count_Households {
  description: "Households. A count of the number of households in each geography. A household consists of one or more people who live in the same dwelling and also share at meals or living accommodation, and may consist of a single family or some other grouping of people."
  type: number
  sql: ${TABLE}.diff_households ;;
}

dimension: Housing_Units {
  description: "Housing Units. A count of housing units in each geography. A housing unit is a house, an apartment, a mobile home or trailer, a group of rooms, or a single room occupied as separate living quarters, or if vacant, intended for occupancy as separate living quarters."
  type: number
  sql: ${TABLE}.diff_housing_units ;;
}

dimension: vacant_housing_units_for_sale {
  description: "Vacant Housing Units for Sale. The count of vacant housing units in a geographic area that are for sale. A housing unit is vacant if no one is living in it at the time of enumeration, unless its occupants are only temporarily absent. Units temporarily occupied at the time of enumeration entirely by people who have a usual residence elsewhere are also classified as vacant."
  type: number
  sql: ${TABLE}.diff_vacant_housing_units_for_sale ;;
}

dimension: owner_occupied_housing_units_lower_value_quartile {
  description: "Owner-Occupied Housing Units Lower Value Quartile"
  type: number
  sql: ${TABLE}.diff_owner_occupied_housing_units_lower_value_quartile ;;
}

dimension: owner_occupied_housing_units_median_value {
  description: "Owner-Occupied Housing Units Median Value. The middle value (median) in a geographic area owner occupied housing units."
  type: number
  sql: ${TABLE}.diff_owner_occupied_housing_units_median_value ;;
}

dimension: owner_occupied_housing_units_upper_value_quartile {
  description: "Owner-Occupied Housing Units Upper Value Quartile."
  type: number
  sql: ${TABLE}.diff_owner_occupied_housing_units_upper_value_quartile ;;
}

dimension: Income_200000_or_More {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_200000_or_more ;;
}

dimension: Income_150000_199999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_150000_199999 ;;
}

dimension: Income_125000_149999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_125000_149999 ;;
}

dimension: Income_100000_124999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_100000_124999 ;;
}

dimension: Income_75000_99999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_75000_99999 ;;
}

dimension: Income_60000_74999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_60000_74999 ;;
}

dimension: income_50000_59999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_50000_59999 ;;
}

dimension: income_45000_49999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_45000_49999 ;;
}

dimension: income_40000_44999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_40000_44999 ;;
}

dimension: income_35000_39999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_35000_39999 ;;
}

dimension: income_30000_34999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_30000_34999 ;;
}

dimension: income_25000_29999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_25000_29999 ;;
}

dimension: income_15000_19999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_15000_19999 ;;
}


dimension: income_10000_14999 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_10000_14999 ;;
}

dimension: income_less_10000 {
  description: "Households with income between the given range as USD. The number of households in a geographic area whose annual income was between the given range as USD."
  type: number
  sql: ${TABLE}.diff_income_10000_14999 ;;
}

dimension: employed_population {
  description: "Employed Population. The number of civilians 16 years old and over in each geography who either (1) were 'at work,' that is, those who did any work at all during the reference week as paid employees, worked in their own business or profession, worked on their own farm, or worked 15 hours or more as unpaid workers on a family farm or in a family business; or (2) were 'with a job but not at work,' that is, those who did not work during the reference week but had jobs or businesses from which they were temporarily absent due to illness, bad weather, industrial dispute, vacation, or other personal reasons. Excluded from the employed are people whose only activity consisted of work around the house or unpaid volunteer work for religious, charitable, and similar organizations; also excluded are all institutionalized people and people on active duty in the United States Armed Forces."
  type: number
  sql: ${TABLE}.diff_employed_pop ;;
}

dimension: bachelors_degree_or_higher_25_64 {
  description: "Population with Bachelors Degree or Higher, Ages 25 to 64. The number of people in each geography who are between the ages of 25 and 64 who have attained a bachelors degree or higher."
  type: number
  sql: ${TABLE}.diff_bachelors_degree_or_higher_25_64 ;;
}

}
