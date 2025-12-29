with orders as (
    select * from {{ ref('orders') }}
),

customers as (
    select * from {{ ref('customers') }}
),

daily_metrics as (
    select
        cast(order_date as date) as date,
        count(*) as total_orders,
        count(distinct customer_id) as unique_customers,
        sum(amount) as total_revenue,
        avg(amount) as average_order_value,
        sum(case when status = 'completed' then 1 else 0 end) as completed_orders,
        sum(case when status = 'processing' then 1 else 0 end) as processing_orders
    from orders
    group by 1
),

with_customer_segments as (
    select
        dm.*,
        count(distinct case when c.customer_segment = 'premium' then o.customer_id end) as premium_customers,
        count(distinct case when c.customer_segment = 'standard' then o.customer_id end) as standard_customers,
        sum(case when c.customer_segment = 'premium' then o.amount else 0 end) as premium_revenue,
        sum(case when c.customer_segment = 'standard' then o.amount else 0 end) as standard_revenue
    from daily_metrics dm
    left join orders o on cast(o.order_date as date) = dm.date
    left join customers c on o.customer_id = c.customer_id
    group by 
        dm.date,
        dm.total_orders,
        dm.unique_customers,
        dm.total_revenue,
        dm.average_order_value,
        dm.completed_orders,
        dm.processing_orders
)

select * from with_customer_segments