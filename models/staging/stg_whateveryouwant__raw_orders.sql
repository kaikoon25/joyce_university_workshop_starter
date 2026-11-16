
with source as (

    select * from {{ source('whateveryouwant', 'raw_orders') }}

),

renamed as (

    select
        id as order_id,
        customer as customer_id,
        timestampt(ordered_at) as ordered_at,
        store_id,
        date(timestamp(ordered_at)) as order_date,
        {{ cents_to_dollars('subtotal') }} as order_subtotal,
        {{ cents_to_dollars('tax_paid') }} as order_tax_paid,
        {{ cents_to_dollars('order_total') }} as order_total


    from source

)

select * from renamed

