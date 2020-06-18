connection: "hcls_covid-19_forecasting"

include: "/**/*.view"                   # include all views in this project


datagroup: hcls_covid19_forecast_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

explore: county_forecast {
  view_name: county_forecast_table

  join: state_info {
      from: state_forecast_table
      relationship: many_to_one
      sql_on: ${county_forecast_table.state} = ${state_info.state} ;;

  }
}

explore: state_forecast_table  {
  view_name: state_forecast_table

  join: county_info {
      from: county_forecast_table
      relationship: one_to_many
      sql_on: ${state_forecast_table.state} = ${county_info.state} ;;
  }
}
