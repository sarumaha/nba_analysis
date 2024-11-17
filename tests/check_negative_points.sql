select *
from {{ ref('fct_player_performance') }}
where total_points < 0
