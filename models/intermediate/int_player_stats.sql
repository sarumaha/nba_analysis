{{ config(materialized='incremental', unique_key='concat(games_game_id, PLAYER_ID)') }}

WITH players_data AS (
    SELECT
        PLAYER_ID,
        PLAYER_NAME,
        TEAM_ID as PLAYER_TEAM_ID
    FROM {{ ref('src_players') }}
),

games_data AS (
    SELECT
        GAMES_GAME_ID,
        GAME_DATE_EST,
        SEASON,
        HOME_TEAM_ID,
        VISITOR_TEAM_ID,
        HOME_TEAM_WINS,
        GAME_STATUS_TEXT
    FROM {{ ref('src_games') }}
),

games_details_data AS (
    SELECT
        DETAILS_GAME_ID,
        DETAILS_team_id,
        TEAM_ABBREVIATION,
        TEAM_CITY,
        PLAYER_ID,
        PLAYER_START_POSITION,
        games_min,
        FGM,
        FGA,
        FG_PCT,
        FT_PCT,
        FG3_PCT,
        FG3M,
        FG3A,
        FTM,
        FTA,
        PTS,
        AST,
        REB,
        STL,
        BLK,
        turnover,
        PF,
        PLUS_MINUS
    FROM {{ ref('src_games_details') }}
),

combined_player_stats AS (
    SELECT
        p.PLAYER_ID,
        p.PLAYER_NAME,
        p.PLAYER_TEAM_ID,
        gd.DETAILS_GAME_ID as details_game_id,
        g.GAME_DATE_EST,
        g.SEASON,
        g.HOME_TEAM_ID,
        g.VISITOR_TEAM_ID,
        g.HOME_TEAM_WINS,
        g.GAME_STATUS_TEXT,
        gd.DETAILS_team_id,
        gd.TEAM_ABBREVIATION,
        gd.TEAM_CITY,
        gd.PLAYER_START_POSITION,
        gd.games_min,
        gd.FGM,
        gd.FGA,
        gd.FG_PCT,
        gd.FT_PCT,
        gd.FG3_PCT,
        gd.FG3M,
        gd.FG3A,
        gd.FTM,
        gd.FTA,
        gd.PTS,
        gd.AST,
        gd.REB,
        gd.STL,
        gd.BLK,
        gd.turnover,
        gd.PF,
        gd.PLUS_MINUS
    FROM players_data p
    JOIN games_details_data gd ON p.PLAYER_ID = gd.PLAYER_ID
    JOIN games_data g ON gd.DETAILS_GAME_ID = g.GAMES_GAME_ID
)

SELECT
    PLAYER_ID,
    PLAYER_NAME,
    DETAILS_GAME_ID as GAME_ID,
    player_team_id,
    GAME_DATE_EST,
    SEASON,
    HOME_TEAM_ID,
    VISITOR_TEAM_ID,
    HOME_TEAM_WINS,
    GAME_STATUS_TEXT,
    DETAILS_team_id,
    TEAM_ABBREVIATION,
    TEAM_CITY,
    PLAYER_START_POSITION,
    games_min,
    FGM,
    FGA,
    FG_PCT,
    FT_PCT,
    FG3_PCT,
    FG3M,
    FG3A,
    FTM,
    FTA,
    PTS,
    AST,
    REB,
    STL,
    BLK,
    turnover,
    PF,
    PLUS_MINUS
FROM combined_player_stats

{% if is_incremental() %}
  WHERE GAME_DATE_EST > (SELECT MAX(GAME_DATE_EST) FROM {{ this }})
{% endif %}
