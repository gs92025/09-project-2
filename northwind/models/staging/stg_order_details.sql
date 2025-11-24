select
  cast(order_id as int) as order_id,
  cast(product_id as int) as product_id,
  cast(unit_price as numeric(12,2)) as unit_price,
  cast(quantity as int) as quantity,
  cast(discount as numeric(6,5)) as discount,
  (unit_price * quantity)::numeric(14,2) as gross_item_amount,
  (unit_price * quantity * discount)::numeric(14,2) as discount_amount,
  (unit_price * quantity * (1 - discount))::numeric(14,2) as net_item_amount
from {{ source('northwind', 'order_details') }}
