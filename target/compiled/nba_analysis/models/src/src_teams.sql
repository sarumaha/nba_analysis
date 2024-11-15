with teams as (
SELECT * FROM NBA_GAMES.RAW.TEAMS
)
SELECT 
CAST(LEAGUE_ID AS INT) as league_id,
CAST(TEAM_ID AS INT) as team_id,
CAST(MIN_YEAR AS INT) as min_year,
CAST(MAX_YEAR AS INT) as max_year,
ABBREVIATION as team_abbreviation,
NICKNAME as team_nickname,
CAST(YEARFOUNDED AS INT) as year_founded,
CITY as city,
ARENA as arena,
ARENACAPACITY as arena_capacity,
OWNER as team_owner,
GENERALMANAGER as general_manager,
HEADCOACH as head_coach,
DLEAGUEAFFILIATION as dleague_affiliation

from teams