view: monthly_inactive_employees {
  derived_table: {
    explore_source: dwh_as054_dim_dienstverband {
      column: activity_month { field: activity_calendar.calendar_month }
      column: fte_cost { field: dwh_as054_dim_verzuimmelding.fte_cost }
      column: inactive_fte { field: dwh_as054_dim_verzuimmelding.inactive_fte }
      column: werknemer_id { field: dwh_as054_dim_verzuimmelding.werknemer_id }
      filters: [activity_calendar.calendar_day_of_month: "1"]
      sorts: [werknemer_id: asc,activity_month: asc]
      derived_column: primary_key {
        sql: CONCAT(activity_month,werknemer_id) ;;
      }
    }

  }

   drill_fields: [werknemer_id,dwh_as054_dim_werknemer.naam,dwh_as054_dim_werknemer.adres,
    dwh_as054_dim_werknemer.naam,dwh_as054_dim_werknemer.nationaliteit
    ,dwh_as054_dim_werknemer.leeftijd,dwh_as054_dim_werknemer.geslacht
  ]
  dimension: primary_key {
    hidden: yes
    primary_key: yes
  }
  dimension: activity_month {
    label: "Activity Month"
  }

  dimension_group: calendar {
    label: "Calendar"
    convert_tz: no
    type: time
    timeframes: [raw,month]
    sql: ${activity_month} ;;
  }

  dimension: fte_cost {
    label: "verzuimmelding Fte Cost"
    type: number
  }

  dimension: inactive_fte {
    label: "verzuimmelding Fte Cost"
    type: number
  }
  dimension: werknemer_id {
    label: "verzuimmelding Werknemer ID"
    type: number
  }

  measure: total_fte_cost {
    type: sum
    sql: ${fte_cost} ;;
    value_format_name: eur
  }

  measure: total_inactive_fte {
    type: sum
    sql: ${inactive_fte} ;;
  }
}
