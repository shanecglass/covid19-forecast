connection: "hcls_covid-19_forecasting"

include: "/**/*.view"                   # include all views in this project


datagroup: hcls_covid19_forecast_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

explore: county_forecast {
  view_name: county_forecast_table
}

explore: state_forecast {
  view_name: state_forecast_table
}
