{% snapshot scd_raw_teams %}

{{
    config(
        target_schema='dev',
        unique_key='team_id',
        strategy='check',
        check_cols=['league_id', 'min_year', 'max_year', 'team_abbreviation', 'team_nickname', 'year_founded', 'city', 'arena', 'arena_capacity', 'team_owner', 'general_manager', 'head_coach', 'dleague_affiliation'],
        invalidate_hard_deletes=True,
        dbt_snapshot_strategy='scd',
        scd_id='version_id',
        scd_start_date='valid_from',
        scd_end_date='valid_to',
        scd_active='is_current'
    )
}}

SELECT
    CAST(LEAGUE_ID AS INT) AS league_id,
    CAST(TEAM_ID AS INT) AS team_id,
    CAST(MIN_YEAR AS INT) AS min_year,
    CAST(MAX_YEAR AS INT) AS max_year,
    ABBREVIATION AS team_abbreviation,
    NICKNAME AS team_nickname,
    CAST(YEARFOUNDED AS INT) AS year_founded,
    CITY AS city,
    ARENA AS arena,
    ARENACAPACITY AS arena_capacity,
    OWNER AS team_owner,
    GENERALMANAGER AS general_manager,
    HEADCOACH AS head_coach,
    DLEAGUEAFFILIATION AS dleague_affiliation
FROM {{ source('nba_games', 'teams') }}

{% endsnapshot %}