view: calendar {
  derived_table: {
    sql: SELECT FORMAT_TIMESTAMP('%Y-%m-%d', timestamp(date) , 'Europe/Brussels') as date
      FROM UNNEST(
          GENERATE_date_ARRAY(DATE('2009-01-01'), DATE('2022-01-01'), INTERVAL 1 DAY)
      ) AS date
 ;;
  }



  dimension_group: calendar {
    type: time
    timeframes: [date,month_num,quarter,quarter_of_year,year,raw, month, month_name, day_of_week, day_of_month, day_of_year]
    sql: cast(${TABLE}.date as timestamp) ;;
  }

  dimension: activity_date {
    label: "Activity Date"
    #this is a type string
    type: string
    hidden: yes
    primary_key: yes
    # hidden: yes
    sql: ${calendar_date} ;;
  }


}
