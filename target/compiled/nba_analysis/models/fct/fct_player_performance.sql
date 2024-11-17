

SELECT
    s.PLAYER_ID,
    s.PLAYER_NAME,
    s.SEASON,
    s.total_points,
    s.total_assists,
    s.total_rebounds,
    s.avg_field_goal_pct,
    s.avg_free_throw_pct,
    s.avg_three_point_pct,
    s.total_field_goals_made,
    s.total_field_goals_attempted,
    s.total_three_points_made,
    s.total_three_points_attempted,
    s.total_free_throws_made,
    s.total_free_throws_attempted,
    s.total_steals,
    s.total_blocks,
    s.total_turnovers,
    s.total_personal_fouls,
    s.games_played,
    s.efficiency_rating,
    -- Per-game averages
    CASE WHEN s.games_played > 0 THEN s.total_points / s.games_played END AS points_per_game,
    CASE WHEN s.games_played > 0 THEN s.total_assists / s.games_played END AS assists_per_game,
    CASE WHEN s.games_played > 0 THEN s.total_rebounds / s.games_played END AS rebounds_per_game,
    CASE WHEN s.games_played > 0 THEN s.total_steals / s.games_played END AS steals_per_game,
    CASE WHEN s.games_played > 0 THEN s.total_blocks / s.games_played END AS blocks_per_game,
    CASE WHEN s.games_played > 0 THEN s.total_turnovers / s.games_played END AS turnovers_per_game,
    -- Effective Field Goal Percentage
    CASE WHEN s.total_field_goals_attempted > 0 THEN
        (s.total_field_goals_made + 0.5 * s.total_three_points_made) / s.total_field_goals_attempted
    END AS effective_field_goal_pct,
    -- True Shooting Percentage
    CASE WHEN (2 * (s.total_field_goals_attempted + 0.44 * s.total_free_throws_attempted)) > 0 THEN
        s.total_points / (2 * (s.total_field_goals_attempted + 0.44 * s.total_free_throws_attempted))
    END AS true_shooting_pct
FROM NBA_GAMES.DEV.int_season_stats s