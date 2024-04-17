view: aantal_transportvoertuigen {
  sql_table_name: `{{ _user_attributes['project'] }}.{{ _user_attributes['cbs_data_logistiek'] }}.Aantal_transportvoertuigen`
    ;;

  dimension: aantal_vrachtwagens {
    type: number
    sql: ${TABLE}.Aantal_vrachtwagens ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: first_name {
    type: string
    sql: 1 ;;
  }

  dimension: last_name {
    type: string
    sql: 1 ;;
  }

#   dimension: full_name {
#     type: string
#     sql: {% if value == "full_name" %}
#   ${TABLE}.full_name
#   {% elsif  %}
#   ${first_name}  ${last_name}
# {% endif %};;
#   }

  dimension_group: year {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.Year ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
