
  create or replace   view NBA_GAMES.DEV.src_games
  
   as (
    with raw_games AS (
SELECT * FROM NBA_GAMES.RAW.GAMES
)
SELECT 
CAST(GAME_DATE_EST AS DATE) as game_date_est,
CAST(GAME_ID AS INT) as games_game_id,
GAME_STATUS_TEXT as game_status_text,
CAST(HOME_TEAM_ID AS INT) as home_team_id, 
CAST(VISITOR_TEAM_ID AS INT) as visitor_team_id,
SEASON as season,
CAST("TEAM_ID_home" AS INT) as team_id_home,
"PTS_home" as pts_home,
"FT_PCT_home" as ft_pct_home,
"FG3_PCT_home" as fg3_pct_home,
"AST_home" as ast_home,
"REB_home" as reb_home,
CAST("TEAM_ID_away" AS INT) as team_id_away,
"PTS_away" as pts_away,
"FG_PCT_away" as fg_pct_away,
"FT_PCT_away" as ft_pct_away,
"FG3_PCT_away" as fg3_pct_away,
"AST_away" as ast_away,
"REB_away" as reb_away,
HOME_TEAM_WINS as home_team_wins
FROM raw_games
  );

