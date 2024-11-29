

WITH seasons AS (
    SELECT * FROM NBA_GAMES.DEV.src_games
)
SELECT DISTINCT
    SEASON AS season_id,
    SEASON AS season_name,
    MIN(GAME_DATE_EST) AS start_date,
    MAX(GAME_DATE_EST) AS end_date
FROM seasons
GROUP BY SEASON