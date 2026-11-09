select
    region,
    regional_manager
from {{ ref('stg_people') }}
