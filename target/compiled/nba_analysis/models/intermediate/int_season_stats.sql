

WITH season_stats AS (
    SELECT
        PLAYER_ID,
        PLAYER_NAME,
        SEASON,
        SUM(PTS) AS total_points,
        SUM(AST) AS total_assists,
        SUM(REB) AS total_rebounds,
        AVG(FG_PCT) AS avg_field_goal_pct,
        AVG(FT_PCT) AS avg_free_throw_pct,
        AVG(FG3_PCT) AS avg_three_point_pct,
        SUM(FGM) AS total_field_goals_made,
        SUM(FGA) AS total_field_goals_attempted,
        SUM(FG3M) AS total_three_points_made,
        SUM(FG3A) AS total_three_points_attempted,
        SUM(FTM) AS total_free_throws_made,
        SUM(FTA) AS total_free_throws_attempted,
        SUM(STL) AS total_steals,
        SUM(BLK) AS total_blocks,
        SUM(turnover) AS total_turnovers,
        SUM(PF) AS total_personal_fouls,
        COUNT(DISTINCT DETAILS_GAME_ID) AS games_played,
        -- Calculate missed shots
        SUM(FGA - FGM) AS missed_field_goals,
        SUM(FTA - FTM) AS missed_free_throws
    FROM NBA_GAMES.DEV.int_player_stats
    GROUP BY PLAYER_ID, PLAYER_NAME, SEASON
)

SELECT
    PLAYER_ID,
    PLAYER_NAME,
    SEASON,
    total_points,
    total_assists,
    total_rebounds,
    avg_field_goal_pct,
    avg_free_throw_pct,
    avg_three_point_pct,
    total_field_goals_made,
    total_field_goals_attempted,
    total_three_points_made,
    total_three_points_attempted,
    total_free_throws_made,
    total_free_throws_attempted,
    total_steals,
    total_blocks,
    total_turnovers,
    total_personal_fouls,
    games_played,
    missed_field_goals,
    missed_free_throws,
    -- Calculate Efficiency (EFF)
    CASE
        WHEN games_played > 0 THEN
            (total_points + total_rebounds + total_assists + total_steals + total_blocks 
             - (missed_field_goals + missed_free_throws + total_turnovers)) / games_played
        ELSE NULL
    END AS efficiency_rating
FROM season_stats