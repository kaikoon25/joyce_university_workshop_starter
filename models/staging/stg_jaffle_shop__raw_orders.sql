

with source as (

    select * from {{ source('jaffle_shop', 'raw_orders') }}

),

renamed as (

    select
        id as order_id,
        customer as customer_id,
        store_id,
        -- Moves store id where it makes more sense
        -- cast(ordered_at as datetime) as order_date,
        -- Or just as ordered_at? order_date makes more sense to me
        timestamp(ordered_at) as ordered_at,
        -- Whats the diffirence between this and casting it as timestamp? Shortcut
        date(timestamp(ordered_at)) as order_date,
        {{cents_to_dollars('subtotal')}} as order_subtotal,
        -- Im not too sure what subtotal is
        {{cents_to_dollars('tax_paid')}} as order_tax_paid,
        {{cents_to_dollars('order_total')}} as order_total
        -- Im not too sure what order total is either

    from source

)

select * from renamed

