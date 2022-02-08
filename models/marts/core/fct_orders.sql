with total as (
    select order_id,
    sum(amount) as amount
    from {{ref('stg_payments')}}
    group by order_id
),
fct_orders as (
    select stg_orders.customer_id,
    stg_orders.order_id,
    total.amount
    from {{ref('stg_orders')}} stg_orders
    left join total using (order_id)
)
select * from fct_orders