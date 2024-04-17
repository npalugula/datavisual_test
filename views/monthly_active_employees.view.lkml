view: monthly_active_fte {
  derived_table: {
    explore_source: dwh_as054_dim_dienstverband {
      column: activity_month { field: activity_calendar.calendar_month }
      column: active_wage {}
      column: active_fte {}
      column: werknemer_id {}
      derived_column: prior_amt {
        sql: lag(active_wage) over (partition by werknemer_id order by activity_month asc) ;;
      }
      derived_column: post_amt {
        sql:lead(active_wage) over (partition by werknemer_id order by activity_month asc);;
      }
      derived_column: prior_count{
        sql: lag(active_fte) over (partition by werknemer_id order by activity_month asc) ;;
      }
      derived_column: post_count {
        sql:lead(active_fte) over (partition by werknemer_id order by activity_month asc);;
      }
      derived_column: primary_key {
        sql: CONCAT(activity_month,werknemer_id) ;;
      }
      filters: [activity_calendar.calendar_day_of_month: "1"]
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

  dimension: active_wage {
    type: number
  }

  dimension: active_fte {
    type: number
  }
  dimension: werknemer_id {

    type: number
  }

  dimension: prior_count {

    type: number
  }

  dimension: post_count {

    type: number
  }


  measure: total_active_wage {
    type: sum
    sql: ${active_wage} ;;
    value_format_name: eur
  }

  measure: total_active_fte {
    type: sum
    sql: ${active_fte} ;;
    value_format_name: decimal_0
  }

  dimension: prior_amt {

    type: number
    value_format_name: eur
  }

  dimension: post_amt {

    type: number
    value_format_name: eur
  }


  dimension_group: current {
    hidden: yes
    type: time
    sql: current_date ;;
  }


  dimension: status {
    type: string
    sql: case when ${prior_count} =0 then 'new hire'
       when ${calendar_month}<${current_month}
       and ${post_count} =0 then 'departure'
       when ${prior_count} = ${active_fte} then 'recurring'
       when ${prior_count} <>0 and ${prior_count} > ${active_fte} then 'salary decrease'
       when ${prior_count} <>0 and ${prior_count} < ${active_fte} then 'salary increase'
       else null end ;;
  }

  dimension: net_mrr {
    type: number
    sql: case when ${prior_count} =0 then ${active_fte} --activation
       when ${calendar_month}<${current_month}
 and ${post_count} =0 then -1*${active_fte} --churn
 when ${prior_count} = ${active_fte} then 0 --recurring
 when ${prior_count} <>0   then ${active_fte} - ${prior_count} --expansion contraction
 else null end ;;
  }

  measure: total_net_mrr {
    type: sum
    sql: ${net_mrr} ;;
    value_format_name: decimal_0
  }

  dimension: is_hired {
    type: yesno
    sql:${prior_count} =0  ;;
  }

  dimension: is_departed {
    type: yesno
    sql:${calendar_month}<${current_month}
      and ${post_count} =0  ;;
  }

  dimension: is_recurring {
    type: yesno
    sql:${prior_count} = ${active_fte}  ;;
  }

  dimension: is_salary_decrease {
    type: yesno
    sql:${prior_amt} !=0 and ${prior_amt} > ${active_wage} and ${post_amt} !=0  ;;# prior expression: is not null
  }

  dimension: is_salary_increase {
    type: yesno
    sql:${prior_amt} !=0 and ${prior_amt} < ${active_wage}  ;;# prior expression: is not null
  }

  measure: total_hired {
    type: sum
    sql: ${active_fte} ;;
    filters: [is_hired: "Yes"]
  }

  measure: total_departed {
     type: sum
    sql: ${active_fte} ;;
    filters: [is_departed: "Yes"]
  }


  measure: total_stayed {
    type: sum
    sql: ${active_fte} ;;
    filters: [is_recurring: "Yes"]
  }


  measure:turnover {
    type: number
    sql: ${total_departed}/nullif(${total_active_fte},0) ;;
    value_format_name: percent_2
  }

  measure:net_retention {
    type: number
    sql: ${total_stayed}/nullif(${total_active_fte},0) ;;
    value_format_name: percent_2
  }


}
