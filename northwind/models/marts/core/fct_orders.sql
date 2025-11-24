/*-- models/marts/core/fct_orders.sql 
-- Fact table at the order level, aggregating line items and freight charges. Each row represents a unique order.  */
with items as (
    select
        order_id,
        sum(quantity) as total_quantity,
        sum(net_item_amount) as net_amount
    from {{ ref('stg_order_details') }}
    group by order_id
),
orders as (
    select * from {{ ref('stg_orders') }}
)
select
    o.order_id,
    o.order_date,
    o.customer_id,
    o.employee_id,
    o.shipper_id,
    o.freight,
    coalesce(i.total_quantity, 0) as total_quantity,
    coalesce(i.net_amount, 0) + coalesce(o.freight, 0) as total_order_amount
from orders o
left join items i using (order_id)
