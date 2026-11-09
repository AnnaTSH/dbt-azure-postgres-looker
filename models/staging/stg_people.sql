with source as (

    select *
    {% if target.name == 'dev' %}
    from {{ ref('people') }}
    {% else %}
    from {{ source('raw', 'people') }}
    {% endif %}

)

select
    regional_manager::text as regional_manager,
    region::text as region
from source
