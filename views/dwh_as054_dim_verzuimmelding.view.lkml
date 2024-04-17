view: dwh_as054_dim_verzuimmelding {
  derived_table: {
    sql: SELECT DISTINCT * FROM `ronald-van-heerikhuize-test.{{ _user_attributes['dataset'] }}.DWH_AS054_dim_verzuimmelding`  ;;
  }

  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: cluster_herstel_melding_id {
    type: number
    sql: ${TABLE}.ClusterHerstelMeldingId ;;
  }

  dimension: d730_correctie {
    type: string
    sql: ${TABLE}.d730_correctie ;;
  }

  dimension: d730_einddatum {
    type: string
    sql: ${TABLE}.d730_einddatum ;;
  }

  dimension_group: datum_toegevoegd {
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
    sql: ${TABLE}.datum_toegevoegd ;;
  }

  dimension: dossier_cluster_omschrijving {
    type: string
    sql: ${TABLE}.DossierClusterOmschrijving ;;
  }

  dimension: dossiernaam {
    type: string
    sql: ${TABLE}.Dossiernaam ;;
  }

  dimension: dossiernummer {
    type: number
    sql: ${TABLE}.dossiernummer ;;
  }

  dimension: eind_datum {
    type: string
    sql: ${TABLE}.eind_datum ;;
  }

  dimension: eind_datumcluster {
    type: string
    sql: ${TABLE}.eind_datumcluster ;;
  }

  dimension: eind_datumdossier {
    type: string
    sql: ${TABLE}.eind_datumdossier ;;
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
    sql: ${TABLE}.einddatum ;;
  }

  dimension: herstel_week_dag {
    type: string
    sql: ${TABLE}.HerstelWeekDag ;;
  }

  dimension: hersteldmelding_id {
    type: number
    sql: ${TABLE}.hersteldmelding_id ;;
  }

  dimension: is_eerste_melding {
    type: string
    sql: ${TABLE}.is_eerste_melding ;;
  }

  dimension: is_herstel_melding {
    type: number
    sql: ${TABLE}.IsHerstelMelding ;;
  }

  dimension: is_hersteldmelding {
    type: number
    sql: ${TABLE}.is_hersteldmelding ;;
  }

  dimension: is_herstelmelding_org {
    type: number
    sql: ${TABLE}.is_herstelmelding_org ;;
  }

  dimension: is_melding {
    type: number
    sql: ${TABLE}.is_melding ;;
  }

  dimension: is_melding_org {
    type: number
    sql: ${TABLE}.is_melding_org ;;
  }

  dimension: lopend_verzuim_duur {
    type: number
    sql: ${TABLE}.LopendVerzuimDuur ;;
  }

  dimension: meldingduur {
    type: number
    sql: ${TABLE}.Meldingduur ;;
  }

  dimension: meldingsdag {
    type: number
    sql: ${TABLE}.Meldingsdag ;;
  }

  dimension: omgeving_id {
    type: number
    sql: ${TABLE}.omgeving_id ;;
  }

  dimension: percentage_at {
    type: number
    sql: ${TABLE}.percentage_at ;;
  }

  dimension: percentage_ziek {
    type: string
    sql: ${TABLE}.percentage_ziek ;;
  }

  dimension: protocol_id {
    type: number
    sql: ${TABLE}.protocol_id ;;
  }

  dimension: recid {
    type: number
    value_format_name: id
    sql: ${TABLE}.recid ;;
  }

  dimension: reden_ziekmelding {
    type: string
    sql: ${TABLE}.reden_ziekmelding ;;
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

  dimension_group: start_datumcluster {
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
    sql: ${TABLE}.start_datumcluster ;;
  }

  dimension_group: start_datumdossier {
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
    sql: ${TABLE}.start_datumdossier ;;
  }

  dimension: start_week_dag {
    type: string
    sql: ${TABLE}.StartWeekDag ;;
  }

  dimension_group: startdatum {
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
    sql: ${TABLE}.startdatum ;;
  }

  dimension: uren_eerste_ziektedag {
    type: number
    sql: ${TABLE}.uren_eerste_ziektedag ;;
  }

  dimension: uwvverzuim_duur {
    type: number
    sql: ${TABLE}.UWVVerzuimDuur ;;
  }

  dimension: verantwoordelijke_gebruiker {
    type: number
    sql: ${TABLE}.verantwoordelijke_gebruiker ;;
  }

  dimension: verantwoordelijke_gebruiker_id {
    type: number
    sql: ${TABLE}.verantwoordelijke_gebruiker_id ;;
  }

  dimension: verlengd_verzuim {
    type: string
    sql: ${TABLE}.verlengd_verzuim ;;
  }

  dimension: verzuimcategorie {
    type: string
    sql: ${TABLE}.verzuimcategorie ;;
  }

  dimension: verzuimid {
    type: string
    sql: ${TABLE}.Verzuimid ;;
  }

  dimension: verzuimomschrijving {
    type: string
    sql: ${TABLE}.Verzuimomschrijving ;;
  }

  dimension: verzuimreden {
    type: string
    sql: ${TABLE}.verzuimreden ;;
  }

  dimension: verzuimreden_id {
    type: number
    sql: ${TABLE}.verzuimreden_id ;;
  }

  dimension: werknemer_id {
    type: number
    sql: ${TABLE}.werknemer_id ;;
  }

  dimension: sickness_duration {
    type: duration_day
    sql_start: ${start_date} ;;
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

    measure: fte_cost {
      # hidden: yes
      type: sum
      sql:
           ${dwh_as054_dim_dienstverband.daily_wage}
           ;;
      filters: [is_active_contract_calendar:"Yes"]

    }

    measure: inactive_fte{
      # hidden: yes
      description: "The count of unique employee absentee "
      type: sum
      sql:
          ${dwh_as054_dim_dienstverband.fte}
          ;;
      filters: [is_active_contract_calendar:"Yes"]

    }

  measure: total_sickness {
    type: sum
    sql: ${sickness_duration} ;;
  }

  measure: count {
    type: count
  }
}
