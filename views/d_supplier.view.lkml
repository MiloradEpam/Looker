view: d_supplier {
  sql_table_name: "DATA_MART"."D_SUPPLIER"
    ;;

  dimension: s_acctbal {
    type: number
    sql: ${TABLE}."S_ACCTBAL" ;;
  }

  dimension: s_address {
    type: string
    sql: ${TABLE}."S_ADDRESS" ;;
  }

  dimension: s_name {
    type: string
    sql: ${TABLE}."S_NAME" ;;
  }

  dimension: s_nation {
    type: string
    sql: ${TABLE}."S_NATION" ;;
  }

  dimension: s_phone {
    type: string
    sql: ${TABLE}."S_PHONE" ;;
  }

  dimension: s_region {
    type: string
    sql: ${TABLE}."S_REGION" ;;
  }

  dimension: s_suppkey {
    type: number
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: SupplierByAccountBalance {
    label: "Cohort of suppliers according to Account Balance"
    type: tier
    sql: ${s_acctbal} ;;
    tiers: [0, 3000, 5000, 7000]
    style: integer
  }

  measure: count {
    type: count
    drill_fields: [s_name]
  }
}
