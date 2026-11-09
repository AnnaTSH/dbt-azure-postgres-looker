with source as (

    select *
    {% if target.name == 'dev' %}
    from {{ ref('returns') }}
    {% else %}
    from {{ source('raw', 'returns') }}
    {% endif %}

)

select distinct
    order_id::text as order_id,
    true as returned
from source
where lower(returned::text) = 'yes'
