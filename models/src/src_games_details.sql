WITH raw_games_details as (
SELECT * FROM NBA_GAMES.RAW.GAMES_DETAILS
)

SELECT 
CAST(GAME_ID AS INT) as details_game_id,
CAST(TEAM_ID AS INT) as details_team_id,
TEAM_ABBREVIATION as team_abbreviation,
TEAM_CITY as team_city,
CAST(PLAYER_ID AS INT) as player_id,
PLAYER_NAME as player_name,
NICKNAME as player_nickname,
START_POSITION as player_start_position,
COMMENT as comment_text, 
MIN as games_min,
FGM as fgm,
FGA as fga,
FG_PCT as fg_pct,
FG3M as fg3m,
FG3A as fg3a,
FG3_PCT as fg3_pct,
FTM as ftm,
FTA as fta,
FT_PCT as ft_pct,
OREB as oreb,
DREB as dreb,
REB as reb,
AST as ast,
STL as stl,
BLK as blk,
"TO" as turnover,
PF as pf,
PTS as pts,
PLUS_MINUS as plus_minus


FROM raw_games_details