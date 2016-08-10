- view: users
  sql_table_name: public.users
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: age
    type: number
    sql: ${TABLE}.age
    
    
  - dimension: age_group
    type: tier
    tiers: [0,10,20,30,40,50,60,70,80]
    style: integer                      # the default value, could be excluded
    sql: ${age}

  - dimension: city
    type: string
    sql: ${TABLE}.city

  - dimension: country
    full_suggestions: true
    type: string
    sql: ${TABLE}.country

  - dimension_group: created
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.created_at

  - dimension: email
    type: string
    sql: ${TABLE}.email
    html:  |
      {% if value == 'william.smith@gmail.com' %}
        <font color="darkgreen">{{ rendered_value }}</font>
      {% else %}
        <font color="black">{{ rendered_value }}</font>
      {% endif %}
    
  - dimension: IsUKEmail
    type: string
    sql_case: 
      IsSmith: ${email} like 'smith'
      else: Unknown
    html:  |
      {% if value == 'IsSmith' %}
        <font color="darkgreen">{{ rendered_value }}</font>
      {% else %}
        <font color="red">{{ rendered_value }}</font>
      {% endif %}
      


  - dimension: emailicon
    type: string
    sql: ${email}
    html: |
      <a href="mailto:{{ value }}" target="_blank">
        <img src="https://upload.wikimedia.org/wikipedia/commons/4/4e/Gmail_Icon.png" width="16" height="16" />
      </a>
      {{ linked_value }}


  - dimension: first_name
    type: string
    sql: ${TABLE}.first_name

  - dimension: gender
    type: string
    sql: ${TABLE}.gender

  - dimension: last_name
    type: string
    sql: ${TABLE}.last_name

  - dimension: full_name
    type: string
    sql: ${first_name} + ' ' + ${last_name}
    
  - dimension: is_user_over_18
    type: yesno
    sql: ${TABLE}.age > 18

  - dimension: state
    type: string
    sql: ${TABLE}.state
    html:  |
      {% if value == 'Iowa' %}
        <font color="darkgreen">{{ rendered_value }}</font>
      {% else %}
        <font color="black">{{ rendered_value }}</font>
      {% endif %}

  - dimension: traffic_source
    type: string
    sql: ${TABLE}.traffic_source

  - dimension: zip
    type: zipcode
    sql: ${TABLE}.zip

  - measure: count
    type: count
    drill_fields: [id, first_name, last_name, orders.count, email]
    
     
  - measure: count_percent_of_total
    label: Count (Percent of Total)
    type: percent_of_total
    drill_fields: detail*
    value_format_name: decimal_1
    sql: ${count}
    
  - measure: min_date
    type: date
    drill_fields: detail*
    sql: min(${created_date})

  - measure: count_of_unique_states
    type: count_distinct
    sql: ${state}

