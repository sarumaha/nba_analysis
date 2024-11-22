
  create or replace   view NBA_GAMES.DEV.stg_player_information
  
   as (
    WITH player_information AS (
    SELECT 
        TEAM_ID,
        SEASON,
        LEAGUE_ID,
        player_name,
        PLAYER_POSITION,
        HEIGHT,
        WEIGHT,
        BIRTH_DATE,
        AGE,
        SCHOOL
    FROM NBA_GAMES.DEV.src_player_information s
),
player_information_cleaned AS (
    SELECT 
        TEAM_ID,
        SEASON,
        LEAGUE_ID,
        player_name,
        PLAYER_POSITION,
        -- Convert height from "feet-inches" to centimeters
        CAST(SPLIT_PART(HEIGHT, '-', 1) AS INTEGER) * 30.48 + 
        CAST(SPLIT_PART(HEIGHT, '-', 2) AS INTEGER) * 2.54 AS HEIGHT_CM,
        WEIGHT,
        BIRTH_DATE,
        AGE,
        SCHOOL
    FROM player_information
    WHERE player_name IS NOT NULL -- Filter out rows with missing player names
)

SELECT 
    TEAM_ID,
    SEASON,
    LEAGUE_ID,
    player_name,
    PLAYER_POSITION,
    HEIGHT_CM,
    WEIGHT,
    BIRTH_DATE,
    AGE,
    SCHOOL
FROM player_information_cleaned
  );

