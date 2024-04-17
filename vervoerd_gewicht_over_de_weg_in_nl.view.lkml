view: vervoerd_gewicht_over_de_weg_in_nl {
  sql_table_name: `{{ _user_attributes['project'] }}.{{ _user_attributes['cbs_data_logistiek'] }}.Vervoerd_gewicht_over_de_weg_in_NL`
    ;;

  dimension: soort_vervoer {
    type: string
    sql: ${TABLE}.Soort_vervoer ;;
  }

  dimension: weight_in_kg {
    type: number
    sql: ${TABLE}.Weight_in_kg ;;
  }

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
