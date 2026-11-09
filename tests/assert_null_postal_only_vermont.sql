select
    row_id,
    state,
    postal_code
from {{ ref('stg_orders') }}
where (
    postal_code is null
    and state <> 'Vermont'
) or (
    postal_code is not null
    and length(postal_code) <> 5
)
