select distinct
    md5(
        concat_ws(
            '|',
            city,
            state,
            coalesce(postal_code, ''),
            region,
            country
        )
    ) as location_id,
    city,
    state,
    postal_code,
    region,
    country
from {{ ref('stg_orders') }}
