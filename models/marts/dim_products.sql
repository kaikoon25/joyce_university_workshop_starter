with products as (
    select * from {{ ref('stg_jaffle_shop__raw_products') }}
),

supplies as (
    select * from {{ ref('stg_jaffle_shop__raw_supplies') }}
)

select
    products.sku,
    products.product_name,
    products.product_type,
    products.product_price,
    supplies.supply_name,
    supplies.supply_cost as cost_to_make,
    supplies.is_perishable
from products
left join supplies on products.sku = supplies.sku
