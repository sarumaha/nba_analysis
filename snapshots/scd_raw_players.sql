{% snapshot scd_raw_players %}

{{
    config(
        target_schema='dev',
        unique_key='concat(player_id, team_id, season)',
        strategy='check',
        check_cols=['player_id', 'team_id', 'season'],
        invalidate_hard_deletes=True,
        dbt_snapshot_strategy='scd',
        scd_id='version_id',
        scd_start_date='valid_from',
        scd_end_date='valid_to',
        scd_active='is_current'
    )
}}

SELECT
    PLAYER_NAME AS player_name,
    CAST(TEAM_ID AS INT) AS team_id,
    CAST(PLAYER_ID AS INT) AS player_id,
    CAST(SEASON AS INT) AS season
FROM {{ source('nba_games', 'players') }}

{% endsnapshot %}


