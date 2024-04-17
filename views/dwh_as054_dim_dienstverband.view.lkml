view: dwh_as054_dim_dienstverband {
  derived_table: {
    sql: SELECT DISTINCT * FROM `ronald-van-heerikhuize-test.{{ _user_attributes['dataset'] }}.DWH_AS054_dim_dienstverband`
    ;;

    }
  drill_fields: [id,dwh_as054_dim_werknemer.naam,dwh_as054_dim_werknemer.nationaliteit
    ,dwh_as054_dim_werknemer.leeftijd,dwh_as054_dim_werknemer.geslacht
    ,monthly_wage,fte]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: afdeling_id {
    type: number
    sql: ${TABLE}.afdeling_id ;;
  }

  dimension: bruto_loon {
    type: number
    sql: ${TABLE}.bruto_loon ;;
  }

  dimension: dienstverbandomschrijving {
    type: string
    sql: ${TABLE}.Dienstverbandomschrijving ;;
  }

  dimension_group: eind {
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
    sql: ${TABLE}.eind_datum ;;
  }

  dimension: fte {
    type: number
    sql: ${TABLE}.fte ;;
  }

  dimension: hoofd_dv {
    type: number
    sql: ${TABLE}.hoofd_dv ;;
  }



  dimension: normuren_per_week {
    type: number
    sql: ${TABLE}.normuren_per_week ;;
  }

  dimension: omgeving_id {
    type: number
    sql: ${TABLE}.omgeving_id ;;
  }

  dimension: salaris_periode {
    type: string
    sql: ${TABLE}.salaris_periode ;;
  }

  dimension: soort_dienstverband_id {
    type: number
    sql: ${TABLE}.soort_dienstverband_id ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_datum ;;
  }

  dimension: sv_loon {
    type: number
    sql: ${TABLE}.sv_loon ;;
  }

  dimension: uniform_loon {
    type: number
    sql: ${TABLE}.uniform_loon ;;
  }

  dimension: uren_per_week {
    type: number
    sql: ${TABLE}.uren_per_week ;;
  }

  dimension: werknemer_id {
    type: number
    sql: ${TABLE}.werknemer_id ;;
  }

  measure: count {
    type: count
  }

  measure: total_fte {
    type: sum
    sql: ${fte} ;;
  }

  dimension: daily_wage {
    type: number
    sql: case when salaris_periode='maand' then ${bruto_loon}/30
         when salaris_periode='dag' then ${bruto_loon}
        when salaris_periode='week' then ${bruto_loon}/7 end;;
  }

  dimension: monthly_wage {
    type: number
    sql: case when salaris_periode='maand' then ${bruto_loon}
         when salaris_periode='dag' then ${bruto_loon}*30
        when salaris_periode='week' then ${bruto_loon}*4.3 end;;
  }

  measure: total_monthly_wage {
    type: sum
    sql: ${monthly_wage} ;;
  }

  measure: total_daily_wage {
    type: sum
    sql: ${daily_wage} ;;
  }

  dimension: is_active {
    type: yesno
    sql: ${eind_date} is not null ;;
  }

  dimension: months_in_duration {
    type: duration_month
    sql_start: ${start_raw} ;;
    sql_end: case when date(${eind_raw})is null then current_date else date(${eind_raw}) end ;;
  }




  dimension: is_active_contract_calendar {
    label: "Is Active Contract Calendar"
    hidden: yes
    #used in NDT to find active accounts
    type: yesno
    sql:
        --add buffer window
           ${start_date} <= ${activity_calendar.calendar_date}
          --buffer window for renewals
          and (${eind_date} is NULL or ${eind_date} > ${activity_calendar.calendar_date});;


    }

    measure: active_wage {
      # hidden: yes
      type: sum
      sql:
           ${daily_wage}
           ;;
      filters: [is_active_contract_calendar:"Yes"]

    }

    measure: active_fte{
      # hidden: yes
      description: "The count of unique employee absentee "
      type: sum
      sql:
          ${fte}
          ;;
      filters: [is_active_contract_calendar:"Yes"]

    }

}
