with bounds as (
    select min(order_date)::date as min_date, max(order_date)::date as max_date
    from {{ ref('stg_orders') }}
),
dates as (
    select generate_series((select min_date from bounds), (select max_date from bounds), interval '1 day')::date as date_day
)
select
    date_day,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day
from dates