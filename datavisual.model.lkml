connection: "bigquery_-"

include: "/**/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
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

explore: dwh_as054_dim_dienstverband {
  label: "dienstverband"
  view_label: "dienstverband"
  # access_filter: {
  #   field: dwh_as054_dim_werknemer.id
  #   user_attribute: employee
  # }
  join: dwh_as054_dim_werknemer {
    view_label: "werknemer"
    relationship: many_to_one
    sql_on: ${dwh_as054_dim_dienstverband.werknemer_id}=${dwh_as054_dim_werknemer.id} ;;
  }

  join: dwh_as054_dim_verzuimmelding {
    view_label: "verzuimmelding"
    relationship: one_to_many
    sql_on: ${dwh_as054_dim_werknemer.id}=${dwh_as054_dim_verzuimmelding.werknemer_id} ;;
  }

  join: activity_calendar {

    from: calendar
    relationship: many_to_one
    type: cross
  }
}



explore: monthly_inactive_employees {
  join: dwh_as054_dim_werknemer {
    view_label: "werknemer"
    relationship: many_to_one
    sql_on: ${monthly_inactive_employees.werknemer_id}=${dwh_as054_dim_werknemer.id} ;;
  }
}

explore: monthly_active_fte {
  join: dwh_as054_dim_werknemer {
    view_label: "werknemer"
    relationship: many_to_one
    sql_on: ${monthly_active_fte.werknemer_id}=${dwh_as054_dim_werknemer.id} ;;
  }
}

explore: vervoerd_gewicht_over_de_weg_in_nl {
  join:  aantal_transportvoertuigen {
    type:  inner
    relationship: many_to_one
    sql_on: ${vervoerd_gewicht_over_de_weg_in_nl.year_year}=${aantal_transportvoertuigen.year_year};;
  }
}

explore: bitcoin {}
