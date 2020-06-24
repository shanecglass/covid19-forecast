view: county_forecast_table {
  # # You can specify the table name if it's different from the view name:
  derived_table: {
  sql: SELECT
        f.*,
        CONCAT(c.lsad_name, ", ", s.state_name) as county_name,
        state_name
      FROM
        `covid-forecasting-272503.export.forecast_COUNTY_14` f
      JOIN
        `bigquery-public-data.geo_us_boundaries.counties` c ON f.location_id = c.geo_id
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
    sql:  IF(${TABLE}.predicted_metric = "death", ${TABLE}.point_prediction, NULL) ;;
   }

  measure: confirmed_cases{
    description: "Predicted value for a given metric at the specified time horizon"
    type:  running_total
    sql:  IF(${TABLE}.predicted_metric = "confirmed", ${TABLE}.point_prediction, NULL) ;;
  }

  measure: point_prediction{
    description: "Predicted value for a given metric at a specified time"
    type: sum
    sql: ${TABLE}.point_prediction}

  measure: ground_truth{
    description: "Actual value for a given metric at the specified time horizon"
    type:  sum
    sql:  ${TABLE}.ground_truth ;;
   }
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: covid_19_forecast_table {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT

#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
