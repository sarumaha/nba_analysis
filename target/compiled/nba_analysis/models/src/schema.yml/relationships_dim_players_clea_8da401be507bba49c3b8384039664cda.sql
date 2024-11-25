
    
    

with child as (
    select player_id as from_field
    from NBA_GAMES.DEV.dim_players_cleansed
    where player_id is not null
),

parent as (
    select player_id as to_field
    from NBA_GAMES.DEV.dim_players_cleansed
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


