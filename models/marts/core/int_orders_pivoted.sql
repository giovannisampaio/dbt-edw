{% set payment_methods = ['credit_card','coupon','bank_transfer','gift_card'] %}
with payments as (
    select * from {{ref('stg_payments')}}
),
pivoted as (
    select 
    order_id,
    {%- for p in payment_methods %}
    sum (case when payment_method = '{{p}}' then amount else 0 end) as amount_{{p}}
    {%- if not loop.last -%}
    ,
    {%-endif-%}
    {%endfor%}
    from payments
    where status = 'success'
    group by 1
)
select * from pivoted