

WITH players_data AS (
    SELECT
        PLAYER_ID,
        PLAYER_NAME,
        TEAM_ID as PLAYER_TEAM_ID,
        SEASON
    FROM NBA_GAMES.DEV.src_players
), 

games_data AS (
    SELECT
        GAMES_GAME_ID,
        GAME_DATE_EST,
        SEASON,
        HOME_TEAM_ID,
        VISITOR_TEAM_ID,
        HOME_TEAM_WINS,
        GAME_STATUS_TEXT,
        ROW_NUMBER() OVER (PARTITION BY SEASON, HOME_TEAM_ID, VISITOR_TEAM_ID ORDER BY GAME_DATE_EST) as rn 
    FROM NBA_GAMES.DEV.src_games
),

player_game_data AS (
    SELECT  
        p.PLAYER_ID,
        p.PLAYER_NAME,
        p.PLAYER_TEAM_ID,
        g.GAMES_GAME_ID,
        p.SEASON,
        g.GAME_DATE_EST,
        g.HOME_TEAM_WINS,
        g.GAME_STATUS_TEXT
    FROM players_data p
    JOIN games_data g 
        ON p.SEASON = g.SEASON 
        AND (p.PLAYER_TEAM_ID = g.HOME_TEAM_ID OR p.PLAYER_TEAM_ID = g.VISITOR_TEAM_ID)
        AND g.rn = 1 
), 
games_details_data AS (
    SELECT
        CAST(DETAILS_GAME_ID AS INT) AS DETAILS_GAME_ID,
        CAST(DETAILS_TEAM_ID AS INT) AS DETAILS_TEAM_ID,
        PLAYER_ID,
        FGM,
        FGA,
        FG_PCT,
        FG3M,
        FG3A,
        FG3_PCT,
        FTM,
        FTA,
        FT_PCT,
        PTS,
        AST,
        REB,
        STL,
        BLK,
        TURNOVER as turnover,
        PF,
        PLUS_MINUS
        
    FROM NBA_GAMES.DEV.src_games_details
)

SELECT 
    pgd.PLAYER_ID AS player_id,
    pgd.PLAYER_NAME AS player_name,
    pgd.GAMES_GAME_ID AS details_game_id,
    pgd.GAME_DATE_EST AS game_date_est,
    pgd.SEASON AS season,
    pgd.HOME_TEAM_WINS AS home_team_wins,
    pgd.GAME_STATUS_TEXT AS game_status_text,
    COALESCE(MAX(gdd.FGM), 0) AS fgm,
    COALESCE(MAX(gdd.FGA), 0) AS fga,
    COALESCE(MAX(gdd.FG_PCT), 0) AS fg_pct,
    COALESCE(MAX(gdd.FG3M), 0) AS fg3m,
    COALESCE(MAX(gdd.FG3A), 0) AS fg3a,
    COALESCE(MAX(gdd.FG3_PCT), 0) AS fg3_pct,
    COALESCE(MAX(gdd.FTM), 0) AS ftm,
    COALESCE(MAX(gdd.FTA), 0) AS fta,
    COALESCE(MAX(gdd.FT_PCT), 0) AS ft_pct,
    COALESCE(MAX(gdd.PTS), 0) AS pts,
    COALESCE(MAX(gdd.AST), 0) AS ast,
    COALESCE(MAX(gdd.REB), 0) AS reb,
    COALESCE(MAX(gdd.STL), 0) AS stl,
    COALESCE(MAX(gdd.BLK), 0) AS blk,
    COALESCE(MAX(gdd.turnover), 0) AS turnover,
    COALESCE(MAX(gdd.PF), 0) AS pf,
    COALESCE(MAX(gdd.PLUS_MINUS), 0) AS plus_minus
FROM player_game_data pgd
JOIN games_details_data gdd 
    ON pgd.GAMES_GAME_ID = gdd.DETAILS_GAME_ID 
    AND pgd.PLAYER_ID = gdd.PLAYER_ID
    AND pgd.PLAYER_TEAM_ID = gdd.DETAILS_TEAM_ID
GROUP BY 
    pgd.PLAYER_ID,
    pgd.PLAYER_NAME,
    pgd.GAMES_GAME_ID,
    pgd.GAME_DATE_EST,
    pgd.SEASON,
    pgd.HOME_TEAM_WINS,
    pgd.GAME_STATUS_TEXT

