select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select start_date
from NBA_GAMES.DEV.dim_seasons
where start_date is null



      
    ) dbt_internal_test