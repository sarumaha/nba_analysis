
      begin;
    merge into "NBA_GAMES"."DEV"."SCD_RAW_TEAMS" as DBT_INTERNAL_DEST
    using "NBA_GAMES"."DEV"."SCD_RAW_TEAMS__dbt_tmp" as DBT_INTERNAL_SOURCE
    on DBT_INTERNAL_SOURCE.dbt_scd_id = DBT_INTERNAL_DEST.dbt_scd_id

    when matched
     
       and DBT_INTERNAL_DEST.dbt_valid_to is null
     
     and DBT_INTERNAL_SOURCE.dbt_change_type in ('update', 'delete')
        then update
        set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to

    when not matched
     and DBT_INTERNAL_SOURCE.dbt_change_type = 'insert'
        then insert ("LEAGUE_ID", "TEAM_ID", "MIN_YEAR", "MAX_YEAR", "TEAM_ABBREVIATION", "TEAM_NICKNAME", "YEAR_FOUNDED", "CITY", "ARENA", "ARENA_CAPACITY", "TEAM_OWNER", "GENERAL_MANAGER", "HEAD_COACH", "DLEAGUE_AFFILIATION", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")
        values ("LEAGUE_ID", "TEAM_ID", "MIN_YEAR", "MAX_YEAR", "TEAM_ABBREVIATION", "TEAM_NICKNAME", "YEAR_FOUNDED", "CITY", "ARENA", "ARENA_CAPACITY", "TEAM_OWNER", "GENERAL_MANAGER", "HEAD_COACH", "DLEAGUE_AFFILIATION", "DBT_UPDATED_AT", "DBT_VALID_FROM", "DBT_VALID_TO", "DBT_SCD_ID")

;
    commit;
  