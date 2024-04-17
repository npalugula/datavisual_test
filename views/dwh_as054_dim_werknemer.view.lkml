view: dwh_as054_dim_werknemer {
  derived_table: {
    sql:SELECT DISTINCT * FROM `ronald-van-heerikhuize-test.{{ _user_attributes['dataset'] }}.DWH_AS054_dim_werknemer`
    ;;
    }
  drill_fields: [id,dwh_as054_dim_werknemer.naam,dwh_as054_dim_werknemer.nationaliteit
    ,dwh_as054_dim_werknemer.leeftijd,dwh_as054_dim_werknemer.geslacht]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: achternaam {
    type: string
    sql: ${TABLE}.achternaam ;;
  }

  dimension: adres {
    type: string
    sql: ${TABLE}.adres ;;
  }

  dimension: bsn {
    type: number
    sql: ${TABLE}.bsn ;;
  }

  dimension: burgerlijke_staat_id {
    type: number
    sql: ${TABLE}.burgerlijke_staat_id ;;
  }

  dimension: burgerlijkestaat {
    type: string
    sql: ${TABLE}.Burgerlijkestaat ;;
  }

  dimension: code {
    type: number
    sql: ${TABLE}.code ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension_group: geboortedatum {
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
    sql: ${TABLE}.geboortedatum ;;
  }

  dimension: geslacht {
    type: string
    sql: ${TABLE}.geslacht ;;
  }

  dimension: huisnummer {
    type: string
    sql: ${TABLE}.huisnummer ;;
  }

  dimension: initialen {
    type: string
    sql: ${TABLE}.initialen ;;
  }

  dimension: kostenplaats {
    type: string
    sql: ${TABLE}.kostenplaats ;;
  }

  dimension: land {
    type: string
    sql: ${TABLE}.Land ;;
  }

  dimension: land_id {
    type: number
    sql: ${TABLE}.land_id ;;
  }

  dimension: leeftijd {
    type: number
    sql: ${TABLE}.leeftijd ;;
  }

  dimension: leeftijd_naam {
    type: string
    sql: ${TABLE}.leeftijd_naam ;;
  }

  dimension: leeftijdklasse {
    type: string
    sql: ${TABLE}.leeftijdklasse ;;
  }

  dimension: leidinggevende {
    type: number
    sql: ${TABLE}.leidinggevende ;;
  }

  dimension: leidinggevende_id {
    type: number
    sql: ${TABLE}.leidinggevende_id ;;
  }

  dimension: naam {
    type: string
    sql: ${TABLE}.naam ;;
    link: {
      label: "{{value}} Analytics Dashboard"
      url: "/dashboards-next/3?Naam={{ value | encode_uri }}"
      icon_url: "http://www.looker.com/favicon.ico"
    }

  }

  dimension: nationaliteit {
    type: string
    sql: ${TABLE}.nationaliteit ;;
  }

  dimension: omgeving_id {
    type: number
    sql: ${TABLE}.omgeving_id ;;
  }

  dimension: plaats {
    type: string
    sql: ${TABLE}.plaats ;;
  }

  dimension: postcode {
    type: string
    sql: ${TABLE}.postcode ;;
  }

  dimension: postcode_nl {
    type: string
    sql: ${TABLE}.postcode_nl ;;
  }

  dimension: sfb {
    type: string
    sql: ${TABLE}.SFB ;;
  }

  dimension: straat {
    type: string
    sql: ${TABLE}.straat ;;
  }

  dimension: telefoon {
    type: string
    sql: ${TABLE}.telefoon ;;
  }

  dimension: unieke_sleutel {
    type: string
    sql: ${TABLE}.unieke_sleutel ;;
  }

  dimension: werknemeromschrijving {
    type: string
    sql: ${TABLE}.Werknemeromschrijving ;;
  }

  dimension: gender_img {
    sql: geslacht ;;
    html: {% if value == 'Man' %}
         <p><img src="https://upload.wikimedia.org/wikipedia/commons/a/ae/Male-s%C3%ADmbolo2.svg" height=50 width=50></p>
      {% elsif value == 'Vrouw' %}
        <p><img src="https://upload.wikimedia.org/wikipedia/commons/b/bc/Female_symbol.svg" height=50 width=50></p>
      {% endif %}
;;
  }

  measure: count {
    type: count
  }
}
