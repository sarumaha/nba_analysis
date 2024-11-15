
  create or replace   view NBA_GAMES.DEV.src_players
  
   as (
    with players as (
SELECT * FROM NBA_GAMES.RAW.PLAYERS
)
SELECT 
PLAYER_NAME as player_name,
CAST(TEAM_ID AS INT) as team_id,
CAST(PLAYER_ID as INT) as player_id,
CAST(SEASON as INT) as season

from players
  );

