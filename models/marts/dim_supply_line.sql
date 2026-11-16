with products as (

    select *
    from {{ ref('stg_jaffle_shop__raw_products') }}

),

supplies as (

    select *
    from {{ ref('stg_jaffle_shop__raw_supplies') }}

),

orders as (

    select *
    from {{ ref('stg_jaffle_shop__raw_orders') }}

),

stores as (

    select *
    from {{ ref('stg_jaffle_shop__raw_stores') }}

),

items as (

    select *
    from {{ ref('stg_jaffle_shop__raw_items') }}

),

product_costs as (

    select
        sku,
        sum(supply_cost) as unit_production_cost
    from supplies
    group by sku

),

product_sales as (

    select
        items.sku,
        stores.store_id,
        stores.store_location,

        count(*) as times_sold,
        sum(products.product_price) as total_revenue

    from items

    join products
        on items.sku = products.sku

    join orders
        on items.order_id = orders.order_id

    join stores
        on orders.store_id = stores.store_id

    group by
        items.sku,
        stores.store_id,
        stores.store_location

)

select
    products.sku,
    products.product_name,
    products.product_type,
    products.product_price,

    product_sales.store_id,
    product_sales.store_location,

    coalesce(product_costs.unit_production_cost, 0)
        as unit_production_cost,

    coalesce(product_sales.times_sold, 0)
        as times_sold,

    coalesce(product_sales.total_revenue, 0)
        as total_revenue,

    coalesce(product_costs.unit_production_cost, 0)
        * coalesce(product_sales.times_sold, 0)
        as total_production_cost,

    coalesce(product_sales.total_revenue, 0)
        - (
            coalesce(product_costs.unit_production_cost, 0)
            * coalesce(product_sales.times_sold, 0)
        )
        as gross_profit

from products

left join product_costs
    on products.sku = product_costs.sku

left join product_sales
    on products.sku = product_sales.sku