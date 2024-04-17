view: bitcoin {
  sql_table_name: `ronald-van-heerikhuize-test.Bitcoin.Bitcoin`
    ;;
  drill_fields: [bits,size,number,hash,timestamp_week]

  dimension: bits {
    type: string
    sql: ${TABLE}.bits ;;
  }

  dimension: coinbase_param {
    type: string
    sql: ${TABLE}.coinbase_param ;;
  }

  dimension: hash {
    type: string
    sql: ${TABLE}.`hash` ;;
  }

  dimension: merkle_root {
    type: string
    sql: ${TABLE}.merkle_root ;;
  }

  dimension: nonce {
    type: string
    sql: ${TABLE}.nonce ;;
  }

  dimension: number {
    type: number
    sql: ${TABLE}.number ;;
  }

  dimension: size {
    type: number
    sql: ${TABLE}.size ;;
  }

  dimension: stripped_size {
    type: number
    sql: ${TABLE}.stripped_size ;;
  }

  dimension_group: timestamp {
    type: time
    timeframes: [
      raw,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.timestamp ;;
  }


  dimension: transaction_count {
    type: number
    sql: ${TABLE}.transaction_count ;;
  }

  dimension: version {
    type: number
    sql: ${TABLE}.version ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }


  measure: total_transaction_count {
    type: sum
    sql: ${transaction_count} ;;
  }

  measure: count {
    type: count
  }
}
