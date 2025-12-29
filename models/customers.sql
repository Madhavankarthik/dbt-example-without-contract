with source as (
    select * from {{ ref('raw_customers') }}
),

staged as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        registration_date,
        customer_segment,
        region
    from source
)

select * from staged