
    
    

with all_values as (

    select
        home_team_wins as value_field,
        count(*) as n_records

    from NBA_GAMES.DEV.src_games
    group by home_team_wins

)

select *
from all_values
where value_field not in (
    '0','1'
)


