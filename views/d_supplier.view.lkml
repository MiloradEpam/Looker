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
    drill_fields: [f_lineitems.TotalGrossRevenue, f_lineitems.TotalCost, f_lineitems.TotalGrossMarginAmount, f_lineitems.GrossMarginPercentage]
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
    primary_key: yes
    type: number
    sql: ${TABLE}."S_SUPPKEY" ;;
  }

  dimension: SupplierByAccountBalance {
    label: "Account Balance group"
    type: tier
    sql: ${s_acctbal} ;;
    tiers: [1, 3001, 5001, 7001]
    style: integer
  }

  measure: count {
    type: count
    drill_fields: [s_name]
  }
}
