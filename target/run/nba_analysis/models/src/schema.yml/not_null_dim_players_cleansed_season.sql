select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select season
from NBA_GAMES.DEV.dim_players_cleansed
where season is null



      
    ) dbt_internal_test