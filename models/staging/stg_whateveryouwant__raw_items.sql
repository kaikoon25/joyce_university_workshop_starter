
with source as (

    select * from {{ source('whateveryouwant', 'raw_items') }}

),

renamed as (

    select
        string_field_0,
        string_field_1,
        string_field_2,
        id as item_id
        order_id,
        sku

    from source

)

select * from renamed

