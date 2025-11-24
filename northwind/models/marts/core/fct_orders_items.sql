SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} AS order_item_key,
    od.order_id,
    od.product_id,
    o.customer_id,
    o.order_date,
    od.unit_price,
    od.quantity,
    od.discount,
    od.net_item_amount
FROM {{ ref('stg_order_details') }} AS od
JOIN {{ ref('stg_orders') }} AS o USING (order_id)