-- back compat for old kwarg name
  
  begin;
    
        
            
                
                
            
                
                
            
        
    

    

    merge into NBA_GAMES.DEV.int_player_stats as DBT_INTERNAL_DEST
        using NBA_GAMES.DEV.int_player_stats__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                    DBT_INTERNAL_SOURCE.DETAILS_GAME_ID = DBT_INTERNAL_DEST.DETAILS_GAME_ID
                ) and (
                    DBT_INTERNAL_SOURCE.PLAYER_ID = DBT_INTERNAL_DEST.PLAYER_ID
                )

    
    when matched then update set
        "PLAYER_ID" = DBT_INTERNAL_SOURCE."PLAYER_ID","PLAYER_NAME" = DBT_INTERNAL_SOURCE."PLAYER_NAME","DETAILS_GAME_ID" = DBT_INTERNAL_SOURCE."DETAILS_GAME_ID","GAME_DATE_EST" = DBT_INTERNAL_SOURCE."GAME_DATE_EST","SEASON" = DBT_INTERNAL_SOURCE."SEASON","HOME_TEAM_WINS" = DBT_INTERNAL_SOURCE."HOME_TEAM_WINS","GAME_STATUS_TEXT" = DBT_INTERNAL_SOURCE."GAME_STATUS_TEXT","FGM" = DBT_INTERNAL_SOURCE."FGM","FGA" = DBT_INTERNAL_SOURCE."FGA","FG_PCT" = DBT_INTERNAL_SOURCE."FG_PCT","FG3M" = DBT_INTERNAL_SOURCE."FG3M","FG3A" = DBT_INTERNAL_SOURCE."FG3A","FG3_PCT" = DBT_INTERNAL_SOURCE."FG3_PCT","FTM" = DBT_INTERNAL_SOURCE."FTM","FTA" = DBT_INTERNAL_SOURCE."FTA","FT_PCT" = DBT_INTERNAL_SOURCE."FT_PCT","PTS" = DBT_INTERNAL_SOURCE."PTS","AST" = DBT_INTERNAL_SOURCE."AST","REB" = DBT_INTERNAL_SOURCE."REB","STL" = DBT_INTERNAL_SOURCE."STL","BLK" = DBT_INTERNAL_SOURCE."BLK","TURNOVER" = DBT_INTERNAL_SOURCE."TURNOVER","PF" = DBT_INTERNAL_SOURCE."PF","PLUS_MINUS" = DBT_INTERNAL_SOURCE."PLUS_MINUS"
    

    when not matched then insert
        ("PLAYER_ID", "PLAYER_NAME", "DETAILS_GAME_ID", "GAME_DATE_EST", "SEASON", "HOME_TEAM_WINS", "GAME_STATUS_TEXT", "FGM", "FGA", "FG_PCT", "FG3M", "FG3A", "FG3_PCT", "FTM", "FTA", "FT_PCT", "PTS", "AST", "REB", "STL", "BLK", "TURNOVER", "PF", "PLUS_MINUS")
    values
        ("PLAYER_ID", "PLAYER_NAME", "DETAILS_GAME_ID", "GAME_DATE_EST", "SEASON", "HOME_TEAM_WINS", "GAME_STATUS_TEXT", "FGM", "FGA", "FG_PCT", "FG3M", "FG3A", "FG3_PCT", "FTM", "FTA", "FT_PCT", "PTS", "AST", "REB", "STL", "BLK", "TURNOVER", "PF", "PLUS_MINUS")

;
    commit;