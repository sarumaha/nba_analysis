select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      

with validation as (
    select
        *,
        case
            when efficiency_rating > 100 then 1
            else 0
        end as invalid_efficiency_rating
    from NBA_GAMES.DEV.int_season_stats
    where efficiency_rating is not null
)

select * from validation
where invalid_efficiency_rating = 1


      
    ) dbt_internal_test