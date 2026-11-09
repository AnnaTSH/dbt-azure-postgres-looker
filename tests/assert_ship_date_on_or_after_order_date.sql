select
    row_id,
    order_date,
    ship_date
from {{ ref('stg_orders') }}
where ship_date < order_date
