WITH player_information AS (
    SELECT * FROM NBA_GAMES.RAW.PLAYER_INFORMATION
)
SELECT 
    "TeamID" AS TEAM_ID,
    SEASON,
    "LeagueID" AS LEAGUE_ID,
    PLAYER AS player_name,
    POSITION AS PLAYER_POSITION,
    HEIGHT,
    WEIGHT,
    -- Convert the birth_date string to a valid DATE
    TO_DATE(BIRTH_DATE, 'MON DD, YYYY') AS BIRTH_DATE,
    AGE AS AGE, 
    SCHOOL AS SCHOOL
FROM player_information