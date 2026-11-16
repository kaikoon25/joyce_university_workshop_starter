with stores as (
    select * from {{ ref('stg_jaffle_shop__raw_stores') }}
)

select * from stores