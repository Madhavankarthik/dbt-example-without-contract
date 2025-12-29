with source as (
    select * from {{ ref('raw_orders') }}
),

staged as (
    select
        order_id,
        customer_id,
        order_date,
        status,
        amount
    from source
)

select * from staged