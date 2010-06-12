
# receiving stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'Receptions', 'receptions_total', NULL, 'american football', 'Rec', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'Yards', 'receptions_yards', NULL, 'american football', 'Yds', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'Touchdowns', 'receptions_touchdowns', NULL, 'american football', 'TD', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'Average yards', 'receptions_average_yards_per', NULL, 'american football', 'Avg', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'Longest', 'receptions_longest', NULL, 'american football', 'Lng', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_receiving_stat', 'First down', 'receptions_first_down', NULL, 'american football', '1st', 2);

# rushing stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'Attempts', 'rushes_attempts', NULL, 'american football', 'Att', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'Yards', 'rushes_yards', NULL, 'american football', 'Yds', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'Touchdowns', 'rushes_touchdowns', NULL, 'american football', 'TD', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'Average yards', 'rushing_average_yards_per', NULL, 'american football', 'Avg', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'Longest', 'rushes_longest', NULL, 'american football', 'Lng', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_rushing_stats', 'american_football_rushing_stat', 'First down', 'rushes_first_down', NULL, 'american football', '1st', 2);

# passing stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Completions', 'passes_completions', 'passes_attempts', 'american football', 'Comp', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Attempts', 'passes_attempts', NULL, 'american football', 'Att', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Percentage', 'passes_percentage', NULL, 'american football', 'Pct', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Yards', 'passes_yards_net', NULL, 'american football', 'Yds', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Average', 'passes_average_yards_per', NULL, 'american football', 'Avg', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Touchdowns', 'passes_touchdowns', NULL, 'american football', 'TD', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Touchdown percentage', 'passes_touchdowns_percentage', NULL, 'american football', 'TD%', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Interceptions', 'passes_interceptions', NULL, 'american football', 'Int', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Interceptions percentage', 'passes_interceptions_percentage', NULL, 'american football', 'Int%', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Longest', 'passes_longest', NULL, 'american football', 'Lng', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_passing_stats', 'american_football_passing_stat', 'Rating', 'passer_rating', NULL, 'american football', 'Rate', 1);

# kick return stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_kick_return_stat', 'Returns', 'returns_kickoff_total', NULL, 'american football', 'Ret', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_kick_return_stat', 'Yards', 'returns_kickoff_yards', NULL, 'american football', 'Yds', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_kick_return_stat', 'Average', 'returns_kickoff_average', NULL, 'american football', 'Avg', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_kick_return_stat', 'Longest', 'returns_kickoff_longest', NULL, 'american football', 'Lng', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_kick_return_stat', 'Touchdowns', 'returns_kickoff_touchdowns', NULL, 'american football', 'TD', 2);

# punt return stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Returns', 'returns_punt_total', NULL, 'american football', 'Ret', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Yards', 'returns_punt_yards', NULL, 'american football', 'Yds', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Average', 'returns_punt_average', NULL, 'american football', 'Avg', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Longest', 'returns_punt_longest', NULL, 'american football', 'Lng', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Touchdowns', 'returns_punt_touchdowns', NULL, 'american football', 'TD', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punt_return_stat', 'Fair catch', 'fair_catches', NULL, 'american football', 'FC', 2);

# defensive stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Tackles total', 'tackles_total', NULL, 'american football', 'Total', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Tackles assist', 'tackles_assist', NULL, 'american football', 'Ast', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Tackles solo', 'tackles_solo', NULL, 'american football', 'Solo', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Sacks', 'sacks_total', NULL, 'american football', 'Sck', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_defensive_stat', 'Safeties', 'safeties_against_opponent', NULL, 'american football', 'Sfty', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Passes defensed', 'passes_defensed', NULL, 'american football', 'Pdef', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Interceptions', 'interceptions_total', NULL, 'american football', 'Int', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Yards', 'interceptions_yards', NULL, 'american football', 'Yds', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Average', 'interceptions_average', NULL, 'american football', 'Avg', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Touchdowns', 'interceptions_touchdown', NULL, 'american football', 'TD', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_defensive_stats', 'american_football_defensive_stat', 'Longest', 'interceptions_longest', NULL, 'american football', 'Lng', 2);

# fumble stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Fumbles', 'fumbles_committed', NULL, 'american football', 'Fum', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Forced', 'fumbles_forced', NULL, 'american football', 'FF', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Lost', 'fumbles_lost', NULL, 'american football', 'Lost', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Recovered', 'fumbles_recovered', NULL, 'american football', 'Rec', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Yards gained', 'fumbles_yards_gained', NULL, 'american football', 'Yds', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_fumbles_stats', 'american_football_fumbles_stat', 'Opposing touchdowns', 'fumbles_opposing_touchdowns', NULL, 'american football', 'TD', 2);

# punting stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Punts', 'punts_total', NULL, 'american football', 'Punts', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Gross yards', 'punts_yards_gross', NULL, 'american football', 'Yds', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Net yards', 'punts_yards_net', NULL, 'american football', 'Net yds', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Longest', 'punts_longest', NULL, 'american football', 'Lng', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Average', 'punts_average', NULL, 'american football', 'Avg', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Blocked', 'punts_blocked', NULL, 'american football', 'Blk', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Punts inside 20', 'punts_inside_20', NULL, 'american football', 'In 20', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_special_teams_stats', 'american_football_punting_stat', 'Touchbacks', 'touchbacks_punts', NULL, 'american football', 'TB', 1);

# field goal stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_field_goal_stat', 'Field goals', 'field_goals_made', NULL, 'american football', 'FG', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_field_goal_stat', 'Attempted', 'field_goals_attempted', NULL, 'american football', 'Att', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_field_goal_stat', 'Blocked', 'field_goals_blocked', NULL, 'american football', 'Blk', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_field_goal_stat', 'Missed', 'field_goals_missed', NULL, 'american football', 'Miss', 1);

# extra point stats
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_extra_point_stat', 'Field goals', 'extra_points_made', NULL, 'american football', 'XP', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_extra_point_stat', 'Attempted', 'extra_points_attempted', NULL, 'american football', 'Att', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_extra_point_stat', 'Blocked', 'extra_points_blocked', NULL, 'american football', 'Blk', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'american_football_scoring_stats', 'american_football_extra_point_stat', 'Missed', 'extra_points_missed', NULL, 'american football', 'Miss', 1);



