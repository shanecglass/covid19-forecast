view: us_blockgroup_boundaries {
  sql_table_name: retail_banking_demo.us_blockgroup_boundaries ;;

  dimension: area_land_meters {
    type: number
    sql: ${TABLE}.area_land_meters ;;
  }

  dimension: area_water_meters {
    type: number
    sql: ${TABLE}.area_water_meters ;;
  }

  dimension: blockgroup_ce {
    type: string
    sql: ${TABLE}.blockgroup_ce ;;
  }

  dimension: blockgroup_geom {
    type: string
    sql: ${TABLE}.blockgroup_geom ;;
  }

  dimension: county_fips_code {
    type: string
    sql: ${TABLE}.county_fips_code ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.county_name ;;
  }

  dimension: functional_status {
    type: string
    sql: ${TABLE}.functional_status ;;
  }

  dimension: geo_id {
    type: string
    sql: ${TABLE}.geo_id ;;
  }

  dimension: internal_point_geom {
    type: string
    sql: ${TABLE}.internal_point_geom ;;
  }

  dimension: internal_point_lat {
    type: number
    sql: ${TABLE}.internal_point_lat ;;
  }

  dimension: internal_point_lon {
    type: number
    sql: ${TABLE}.internal_point_lon ;;
  }

  dimension: lsad_name {
    type: string
    sql: ${TABLE}.lsad_name ;;
  }

  dimension: mtfcc_feature_class_code {
    type: string
    sql: ${TABLE}.mtfcc_feature_class_code ;;
  }

  dimension: state_fips_code {
    type: string
    sql: ${TABLE}.state_fips_code ;;
  }

  dimension: state_name {
    type: string
    sql: ${TABLE}.state_name ;;
  }

  dimension: tract_ce {
    type: string
    sql: ${TABLE}.tract_ce ;;
  }

  measure: count {
    type: count
    drill_fields: [county_name, state_name, lsad_name]
  }
}
