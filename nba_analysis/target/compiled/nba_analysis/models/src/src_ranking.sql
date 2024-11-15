with ranking as (
SELECT * FROM NBA_GAMES.RAW.ranking
)
SELECT 
CAST(TEAM_ID AS INT) as team_id,
CAST(LEAGUE_ID AS INT) as league_id,
CAST(SEASON_ID AS INT) as season_id,
CAST(STANDINGSDATE AS DATE) as standings_date,
CONFERENCE as conference, 
TEAM as team,
G as g,
W as w,
L as l,
W_PCT as w_pct,
HOME_RECORD as home_record,
ROAD_RECORD as road_record,
RETURNTOPLAY as return_to_play
from ranking