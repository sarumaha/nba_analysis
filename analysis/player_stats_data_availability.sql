-- This query investigates the availability of data in two datasets: 
-- NBA_GAMES.RAW.GAMES (recording games starting from 2003) 
-- and NBA_GAMES.RAW.GAMES_DETAILS (recording detailed player stats starting from 2009).
-- The goal is to demonstrate that GAMES_DETAILS only has data from 2009 onward, 
-- while GAMES contains earlier data, starting from 2003.

-- Query Output:
-- The following table shows the output of the query when executed in Snowflake:
-- | Dataset Name   | Earliest Game ID | Total Records | Earliest Game Date | Earliest Season |
-- |----------------|------------------|---------------|---------------------|-----------------|
-- | Games          | NULL             | NULL          | 2003-10-05         | 2003            |
-- | Games Details  | 10900001         | 3159220       | 2009-10-01         | 2009            |

-- Step 1: Get the earliest game_id and total records from the games_details dataset
WITH games_details_summary AS (
    SELECT
        MIN(CAST(GAME_ID AS INT)) AS earliest_game_id, -- Earliest GAME_ID recorded in GAMES_DETAILS
        COUNT(*) AS total_records -- Total number of records in GAMES_DETAILS
    FROM NBA_GAMES.RAW.GAMES_DETAILS
),

-- Step 2: Find the earliest game date and season in GAMES_DETAILS by joining with GAMES
games_details_info AS (
    SELECT
        MIN(g.GAME_DATE_EST) AS earliest_game_date, -- Earliest game date in GAMES_DETAILS
        MIN(g.SEASON) AS earliest_season -- Earliest season in GAMES_DETAILS
    FROM NBA_GAMES.RAW.GAMES g
    JOIN NBA_GAMES.RAW.GAMES_DETAILS gd
        ON g.GAME_ID = CAST(gd.GAME_ID AS INT) -- Join on GAME_ID to retrieve season and game date
),

-- Step 3: Find the earliest game date and season in the GAMES dataset
games_summary AS (
    SELECT
        MIN(GAME_DATE_EST) AS earliest_game_date, -- Earliest game date in GAMES
        MIN(SEASON) AS earliest_season -- Earliest season in GAMES
    FROM NBA_GAMES.RAW.GAMES
),

-- Step 4: Combine the summaries for GAMES_DETAILS and GAMES into a final summary
final_summary AS (
    SELECT
        'Games Details' AS dataset_name, -- Label for GAMES_DETAILS dataset
        gd_summary.earliest_game_id, -- Earliest GAME_ID in GAMES_DETAILS
        gd_summary.total_records, -- Total number of records in GAMES_DETAILS
        gd_info.earliest_game_date, -- Earliest game date in GAMES_DETAILS
        gd_info.earliest_season -- Earliest season in GAMES_DETAILS
    FROM games_details_summary gd_summary
    CROSS JOIN games_details_info gd_info
    
    UNION ALL
    
    SELECT
        'Games' AS dataset_name, -- Label for GAMES dataset
        NULL AS earliest_game_id, -- GAME_ID is not relevant for the GAMES dataset summary
        NULL AS total_records, -- Total records not included for GAMES
        g_summary.earliest_game_date, -- Earliest game date in GAMES
        g_summary.earliest_season -- Earliest season in GAMES
    FROM games_summary g_summary
)

-- Step 5: Display the final summary with relevant details for both datasets
SELECT
    dataset_name, -- Name of the dataset: 'Games' or 'Games Details'
    earliest_game_id, -- Earliest GAME_ID, if applicable
    total_records, -- Total records in the dataset (only for GAMES_DETAILS)
    earliest_game_date, -- Earliest game date in the dataset
    earliest_season -- Earliest season in the dataset
FROM final_summary
ORDER BY dataset_name; -- Order by dataset name for clarity
