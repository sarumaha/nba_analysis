
  create or replace   view NBA_GAMES.DEV.base_NBA_GAMES_TEAMS
  
   as (
    with source as (
      select * from NBA_GAMES.RAW.raw_teams
),
renamed as (
    select
        

    from source
)
select * from renamed
  );

