view: state_forecast_table {
    # # You can specify the table name if it's different from the view name:
  derived_table: {
    sql:
      SELECT
        SUBSTR(location_id, 1,2) AS location_id,
        f.* EXCEPT(location_id),
        state_name
      FROM
        `covid-forecasting-272503.eval.PROD_study_20200615_182857_461` f
      JOIN
        `bigquery-public-data.geo_us_boundaries.states` s ON SUBSTR(f.location_id, 1,2) = s.geo_id
       ;;
   }
    # # Define your dimensions and measures here, like this:
    dimension: state_fips_code {
      description: "Unique ID for each US county in the prediction"
      type: string
      sql: ${TABLE}.location_id ;;
    }

    dimension: state  {
      description: "Full text name of the state"
      type: string
      sql:  ${TABLE}.state_name ;;
      map_layer_name: us_states
    }

    dimension_group: training_window_end {
      description: "Time of the end of the model training window"
      timeframes: [date, hour, week, month, year, hour2, hour3, hour4, hour6, hour12, day_of_week]
      type: time
      sql: ${TABLE}.training_window_end ;;
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
      sql:  ${TABLE}.time_horizon ;;
    }

    measure: point_prediction{
      description: "Predicted value for a given metric at the specified time horizon"
      type:  sum
      sql:  ${TABLE}.point_prediction ;;
    }

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
#
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
