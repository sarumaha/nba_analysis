select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select end_date
from NBA_GAMES.DEV.dim_seasons
where end_date is null



      
    ) dbt_internal_test