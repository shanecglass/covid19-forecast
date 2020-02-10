connection: "google_cloud_public_datasets_program"

# include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
#include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }

map_layer: census_blockgroups {
  feature_key: "Census Blockgroups"
  url: "https://raw.githubusercontent.com/shanecglass/Looker-Demos/8627645cf84f5299a50f300302e677c4453cea1b/blockgroups.json"
  format:  topojson
  property_key: "geo_id"
}
