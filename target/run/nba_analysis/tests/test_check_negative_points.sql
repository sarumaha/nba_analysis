select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      select *
from NBA_GAMES.DEV.fct_player_performance
where total_points < 0
      
    ) dbt_internal_test