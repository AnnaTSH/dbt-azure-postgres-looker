with bounds as (

    select
        min(least(order_date, ship_date)) as start_date,
        max(greatest(order_date, ship_date)) as end_date
    from {{ ref('stg_orders') }}

),

spine as (

    select generate_series(start_date, end_date, interval '1 day')::date as date_day
    from bounds

)

select
    date_day,
    extract(year from date_day)::int as year,
    extract(quarter from date_day)::int as quarter,
    extract(month from date_day)::int as month,
    to_char(date_day, 'FMMonth') as month_name,
    extract(isodow from date_day)::int as iso_day_of_week
from spine
