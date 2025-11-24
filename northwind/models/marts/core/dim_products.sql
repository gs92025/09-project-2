with p as (select * from {{ ref('stg_products') }}),
c as (select * from {{ ref('stg_categories') }})
select
    p.product_id as product_key,
    p.product_name,
    c.category_name,
    p.unit_price
from p
left join c using (category_id)
