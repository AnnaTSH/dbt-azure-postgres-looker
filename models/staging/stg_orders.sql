with source as (

    select *
    {% if target.name == 'dev' %}
    from {{ ref('orders') }}
    {% else %}
    from {{ source('raw', 'orders') }}
    {% endif %}

)

select
    row_id::int as row_id,
    order_id::text as order_id,
    {{ excel_serial_to_date('order_date') }} as order_date,
    {{ excel_serial_to_date('ship_date') }} as ship_date,
    ship_mode::text as ship_mode,
    customer_id::text as customer_id,
    customer_name::text as customer_name,
    segment::text as segment,
    country_region::text as country,
    city::text as city,
    state::text as state,
    {{ postal_code_text('postal_code') }} as postal_code,
    region::text as region,
    product_id::text as product_id,
    category::text as category,
    sub_category::text as sub_category,
    product_name::text as product_name,
    sales::numeric(18, 4) as sales,
    quantity::int as quantity,
    discount::numeric(18, 4) as discount,
    profit::numeric(18, 4) as profit
from source
