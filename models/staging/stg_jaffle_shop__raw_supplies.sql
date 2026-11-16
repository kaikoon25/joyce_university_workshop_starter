
with source as (

    select * from {{ source('jaffle_shop', 'raw_supplies') }}

),


renamed as (

    select
        -- {{dbt_utils.generate_surrogate_key(['id', 'name', 'sku'])}},
        -- Needed a unique because supply id has duplicates
        id as supply_id,
        name as supply_name,
        {{cents_to_dollars('cost')}} as supply_cost,
        cast(perishable as boolean) as is_perishable,
        sku

    from source

)

select * from renamed

