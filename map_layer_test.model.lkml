connection: "google_cloud_public_datasets_program"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#

explore: utah_banks_by_zip {
  view_name: utah_banks_by_zip
}

explore: utah_ACS_changes_2011_2017  {
    view_name: utah_acs_changes_2011_2017
}

explore: utah_ACS_2017_zipcodes {
    view_name: utah_acs_2017_zipcodes
}

explore: utah_ACS_2011_zipcodes {
    view_name: utah_acs_2011_zipcodes
}
