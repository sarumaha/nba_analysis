select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select player_id
from NBA_GAMES.raw.players
where player_id is null



      
    ) dbt_internal_test