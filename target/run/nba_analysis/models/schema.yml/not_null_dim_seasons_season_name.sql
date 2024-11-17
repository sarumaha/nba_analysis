select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select season_name
from NBA_GAMES.DEV.dim_seasons
where season_name is null



      
    ) dbt_internal_test