select
    customer_id as customer_key,
    company_name,
    contact_name,
    city,
    country
from {{ ref('stg_customers') }}
