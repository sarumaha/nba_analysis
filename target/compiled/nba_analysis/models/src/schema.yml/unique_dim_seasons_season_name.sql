
    
    

select
    season_name as unique_field,
    count(*) as n_records

from NBA_GAMES.DEV.dim_seasons
where season_name is not null
group by season_name
having count(*) > 1


