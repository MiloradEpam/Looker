connection: "tpchlooker"

# include all the views
include: "/views/**/*.view"

datagroup: looker_intensive_milorad_lukic_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_intensive_milorad_lukic_default_datagroup

explore: f_lineitems {
  label: "Order Analysis"
  view_label: "Orders"
  join: d_customer {
    view_label: "Customers"
    type: left_outer
    sql_on: ${f_lineitems.l_custkey}=${d_customer.c_custkey};;
    relationship: many_to_one
  }
  join: d_dates {
    view_label: "Ship date"
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_shipdatekey}=${d_dates.datekey} ;;
  }
  join: d_part {
    view_label: "Parts"
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_partkey}=${d_part.p_partkey} ;;
  }
  join: d_supplier {
    view_label: "Suppliers"
    type: left_outer
    relationship: many_to_one
    sql_on: ${f_lineitems.l_suppkey}=${d_supplier.s_suppkey} ;;
  }

}
