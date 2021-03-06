view: county_forecast_table {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
  sql: b.* EXCEPT (point_prediction, target_prediction_date),
        EXTRACT(DATE from b.target_prediction_date) AS target_prediction_date,
        IF(predicted_metric = "death", b.point_prediction, NULL) AS cumulative_deaths,
        IF(predicted_metric = "confirmed)", b.point_prediction, NULL) AS cumulative_confirmed,
        CASE
          WHEN b.predicted_metric = "death" THEN b.point_prediction - a.point_prediction
          WHEN b.predicted_metric = "confirmed" THEN b.point_prediction - a.point_prediction
          ELSE
            b.point_prediction
        END AS point_prediction,
        CONCAT(c.lsad_name, ", ", s.state_name) as county_name,
        state_name
      FROM
        (SELECT
          fips_code,
          point_prediction,
          DATE_ADD(EXTRACT(DATE FROM target_prediction_date), INTERVAL 1 day) AS target_prediction_date
         FROM `covid-forecasting-272503.export.forecast_COUNTY_14`) a
      JOIN
        `covid-forecasting-272503.export.forecast_COUNTY_14` b ON EXTRACT(DATE from b.target_prediction_date) = a.target_prediction_date AND b.fips_code = a.fips_code
      JOIN
        `bigquery-public-data.geo_us_boundaries.counties` c ON b.fips_code = c.geo_id
      JOIN
        `bigquery-public-data.geo_us_boundaries.states` s ON c.state_fips_code = s.geo_id
       ;;
    }


  # # Define your dimensions and measures here, like this:
  dimension: county_fips_code {
    description: "Unique ID for each US county in the prediction"
    type: string
    sql: ${TABLE}.fips_code ;;
    map_layer_name: us_counties_fips
  }

  dimension: state {
    description: "Unique ID for each US state in the prediction"
    type: string
    sql: ${TABLE}.state_name ;;
    map_layer_name: us_states
    drill_fields: [
      county, predicted_metric, point_prediction
    ]
}
  dimension: county  {
    description: "Full text name of the county"
    type: string
    sql:  ${TABLE}.county_name ;;
  }

  dimension_group: training_window_end {
    description: "Time of the end of the model training window"
    timeframes: [date, hour, week, month, year, hour2, hour3, hour4, hour6, hour12, day_of_week]
    type: time
    sql: ${TABLE}.forecast_date ;;
  }
  #
  dimension: predicted_metric{
    description: "The name of the metric that is predicted for a given row"
    type:  string
    sql:  ${TABLE}.predicted_metric;;
  }

  dimension: time_horizon{
    description: "The length into the future that the model is predicting"
    type: number
    sql:  ${TABLE}.target_prediction_date ;;
  }

  measure: deaths{
    description: "Predicted value for a given metric at the specified time horizon"
    type:  running_total
    sql:  ${TABLE}.deaths;;
   }

  measure: confirmed_cases{
    description: "Predicted value for a given metric at the specified time horizon"
    type:  running_total
    sql:  ${TABLE}.confirmed;;
  }

  measure: point_prediction{
    description: "Predicted value for a given metric at a specified time"
    type: sum
    sql: ${TABLE}.point_prediction;; }
}
