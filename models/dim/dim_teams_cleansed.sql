WITH teams AS (
    SELECT * FROM {{ ref('src_teams') }}
)
SELECT
    CASE
        WHEN LEAGUE_ID REGEXP '^[0-9]+$' THEN CAST(LEAGUE_ID AS INT)
        ELSE NULL
    END AS league_id,
    CASE
        WHEN TEAM_ID REGEXP '^[0-9]+$' THEN CAST(TEAM_ID AS INT)
        ELSE NULL
    END AS team_id,
    CASE
        WHEN MIN_YEAR REGEXP '^[0-9]+$' THEN CAST(MIN_YEAR AS INT)
        ELSE NULL
    END AS min_year,
    CASE
        WHEN MAX_YEAR REGEXP '^[0-9]+$' THEN CAST(MAX_YEAR AS INT)
        ELSE NULL
    END AS max_year,
    TEAM_ABBREVIATION AS team_abbreviation,
    TEAM_NICKNAME AS team_nickname,
    CASE
        WHEN year_founded REGEXP '^[0-9]+$' THEN CAST(year_founded AS INT)
        ELSE NULL
    END AS year_founded,
    CITY AS city,
    ARENA AS arena,
    NVL(arena_capacity, 0) AS arena_capacity,
    team_owner AS team_owner,
    general_manager AS general_manager,
    head_coach AS head_coach,
    dleague_affiliation AS dleague_affiliation
FROM teams