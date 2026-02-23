-----------------------------------------------
--- Compare Row Counts
-----------------------------------------------
{% set old_relation = adapter.get_relation(
      database = target.database,
      schema = "refactoring",
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_row_counts(
    a_relation = old_relation,
    b_relation = dbt_relation
) }}

-----------------------------------------------
--- Compare Column Values
-----------------------------------------------

{% set old_relation = adapter.get_relation(
      database = target.database,
      schema = "refactoring",
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_all_columns(
    a_relation = old_relation,
    b_relation = dbt_relation,
    primary_key = "order_id"
) }}

------------------------------------------------
---- Audit: Compare Column Values for Customer Lifetime Value
------------------------------------------------

with legacy as (

  select order_id, customer_lifetime_value from {{ ref('customer_orders_legacy') }}

),
refactored as (

  select order_id, customer_lifetime_value from {{ ref('fct_customer_orders') }}

)
select coalesce(legacy.order_id, re.order_id) as order_id,
legacy.customer_lifetime_value as legacy_customer_lifetime_value,
re.customer_lifetime_value as refactored_customer_lifetime_value,
coalesce(legacy.customer_lifetime_value, re.customer_lifetime_value) as customer_lifetime_value,
(legacy.customer_lifetime_value is not null) as legacy_exists,
(re.customer_lifetime_value is not null) as refactored_exists
from legacy
inner join refactored re on legacy.order_id = re.order_id
where legacy.customer_lifetime_value <> re.customer_lifetime_value
order by order_id