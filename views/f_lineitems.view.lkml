view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS"
    ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_extendedprice {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }

  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }

  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }

  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }

  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }

  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: TotalSalePrice{
    label: "Total Sale Price"
    description: "Sum of Sales in USD"
    type: sum
    sql: ${l_totalprice}  ;;
    value_format_name: usd
  }
  measure: AverageSalePrice {
    label: "Average Sale Price"
    description: "Average of Sales in USD"
    type: average
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }
  measure: CumulativeTotalSales {
    label: "Cumulative Total Sales"
    description: "Running Total of Sales in USD"
    type: running_total
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }
  measure: TotalAirSales {
    label: "Total Air Sales"
    description: "Total sales of items shipped by air in USD"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [l_shipmode: "AIR"]
    value_format_name: usd
  }
  measure: SalesFromRussia {
    label: "Total Russia Sales"
    description: "Total sales by customers from Russia"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [d_customer.c_nation: "RUSSIA"]
    value_format_name: usd
  }
  measure: TotalGrossRevenue {
    label: "Total Gross Revenue"
    description: "Total price of completed sales in USD"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [l_orderstatus: "F"]
    value_format_name: usd
  }
  measure: TotalCost {
    label: "Total Cost"
    description: "Missing"
    type: sum
    sql: ${l_supplycost}  ;;
    value_format_name: usd
  }
  measure: TotalGrossMarginAmount {
    label: "Total Gross Margin"
    type: number
    sql: ${TotalGrossRevenue}-${TotalCost} ;;
    value_format_name: usd
  }
  measure: GrossMarginPercentage {
    label: "Gross Margin %"
    type: number
    sql: ${TotalGrossMarginAmount}/nullif(${TotalGrossRevenue},0) ;;
    value_format_name: percent_1
  }
  measure: NumberOfItemsReturned {
    label: "Items Returned"
    description: "Number of items that were returned by dissatisfied customers"
    type: sum
    sql: ${l_quantity} ;;
    filters: [l_returnflag: "R"]
  }
  measure: TotalNumberOfItemsSold {
    label: "Items Sold"
    description: "Number of items that were sold"
    type: sum
    sql: ${l_quantity} ;;
    filters: [l_orderstatus: "F"]
  }
  measure: ItemReturnRate {
    label: "Return %"
    description: "Number Of Items Returned / Total Number Of Items Sold"
    type: number
    sql: ${NumberOfItemsReturned}/nullif(${TotalNumberOfItemsSold},0) ;;
    value_format_name: percent_1
  }
  measure: CustomerCount {
    label: "Customer Count"
    description: "Total Number of Distinct Customers"
    type: count_distinct
    sql: ${l_custkey} ;;

  }
  measure: AverageSpendPerCustomer {
    label: "Average Spend per Customer"
    description: "Total Sale Price / Total Number of Customers"
    type: number
    sql: ${TotalSalePrice}/${CustomerCount} ;;
  }

}
