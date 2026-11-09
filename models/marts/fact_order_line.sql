with orders as (

    select * from {{ ref('stg_orders') }}

),

returns as (

    select * from {{ ref('stg_returns') }}

),

products as (

    select * from {{ ref('dim_product') }}

),

locations as (

    select * from {{ ref('dim_location') }}

)

select
    orders.row_id,
    orders.order_id,
    orders.order_date,
    orders.ship_date,
    orders.ship_mode,
    orders.customer_id,
    products.product_key,
    orders.product_id,
    locations.location_id,
    orders.region,
    orders.sales,
    orders.quantity,
    orders.discount,
    orders.profit,
    coalesce(returns.returned, false) as is_returned
from orders
left join returns
    on orders.order_id = returns.order_id
left join products
    on orders.product_id = products.product_id
    and orders.product_name = products.product_name
left join locations
    on orders.city = locations.city
    and orders.state = locations.state
    and orders.postal_code is not distinct from locations.postal_code
    and orders.region = locations.region
    and orders.country = locations.country
