
# Ice hockey offensive stats

# Priority 1
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, CURDATE(), CURDATE(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Goals', 'goals', NULL, 'ice hockey', 'G', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, CURDATE(), CURDATE(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Assists', 'assists', NULL, 'ice hockey', 'A', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, CURDATE(), CURDATE(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Points', 'points', NULL, 'ice hockey', 'P', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, CURDATE(), CURDATE(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Shots', 'shots', NULL, 'ice hockey', 'G', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, CURDATE(), CURDATE(), 'ice_hockey_player_stats', 'ice_hockey_offensive_stat', 'Plus/Minus', 'plus_minus', NULL, 'ice hockey', '+/-', 1);



INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Game winning goals', 'goals_game_winning', NULL, 'ice hockey', 'GWG', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Game tying goals', 'goals_game_tying', NULL, 'ice hockey', 'GTG', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Power play goals', 'goals_power_play', NULL, 'ice hockey', 'PPG', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Short handed goals', 'goals_short_handed', NULL, 'ice hockey', 'GSH', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Even strength goals', 'goals_even_strength', NULL, 'ice hockey', 'GES', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Empty net goals', 'goals_empty_net', NULL, 'ice hockey', 'GEN', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Overtime goals', 'goals_game_winning', NULL, 'ice hockey', 'GOT', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Shootout goals', 'goals_shootout', NULL, 'ice hockey', 'GSO', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Penalty shot goals', 'goals_penalty_shot', NULL, 'ice hockey', 'GPS', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Penalty shots taken', 'shots_penalty_shot_taken', 'shots_penalty_shot_missed', 'ice hockey', 'PST', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Penalty shot percentage', 'shots_penalty_shot_percentage', NULL, 'ice hockey', 'PS%', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Shots missed', 'shots_missed', NULL, 'ice hockey', 'SM', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Shots blocked', 'shots_blocked', NULL, 'ice hockey', 'SB', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Game winning goals', 'goals_game_winning', NULL, 'ice hockey', 'GWG', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Power play shots', 'shots_power_play', NULL, 'ice hockey', 'PPS', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Short handed shots', 'shots_short_handed', NULL, 'ice hockey', 'SSH', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Even strength shots', 'shots_even_strength', NULL, 'ice hockey', 'ESS', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Game winning goals', 'goals_game_winning', NULL, 'ice hockey', 'GWG', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Faceoff wins', 'faceoff_wins', NULL, 'ice hockey', 'FOW', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Faceoff loses', 'faceoff_loses', NULL, 'ice hockey', 'FOL', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Faceoff win %', 'faceoff_win_percentage', NULL, 'ice hockey', 'FO %', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_offensive_stats', 'ice_hockey_offensive_stat', 'Scoring chances', 'scoring_chances', NULL, 'ice hockey', 'SC', 3);


# ice hockey defensive stats


INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Power play goals allowed', 'goals_power_play_allowed', NULL, 'ice hockey', 'PP GA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Penalty shot goals allowed', 'goals_penalty_shot_allowed', NULL, 'ice hockey', 'PS GA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Empty net goals allowed', 'goals_empty_net_allowed', NULL, 'ice hockey', 'EN GA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Goals against average', 'goals_against_average_allowed', NULL, 'ice hockey', 'GA', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Short handed goals allowed', 'goals_short_handed_allowed', NULL, 'ice hockey', 'SH GA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Shootout goals allowed', 'goals_shootout_allowed', NULL, 'ice hockey', 'SO GA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Power play shots allowed', 'shots_power_play_allowed', NULL, 'ice hockey', 'PP SA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Penalty shots allowed', 'shots_penalty_shot_allowed', NULL, 'ice hockey', 'PSA', 3);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Blocked shots', 'shots_blocked', NULL, 'ice hockey', 'SB', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Saves', 'saves', NULL, 'ice hockey', 'Saves', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Save %', 'save_percentage', NULL, 'ice hockey', 'Save %', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Takeaways', 'takeaways', NULL, 'ice hockey', 'TA', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Shutouts', 'shutouts', NULL, 'ice hockey', 'SO', 2);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Hits', 'hits', NULL, 'ice hockey', 'H', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Goals allowed', 'goals_allowed', NULL, 'ice hockey', 'GA', 1);
INSERT INTO stats_mappings (`id`, `created_at`, `updated_at`, `stats_table`, `stats_type`, `stats_name`, `stats_field`, `counter_field`, `sport`, `abbreviation`, `priority`) VALUES (NULL, NOW(), NOW(), 'ice_hockey_defensive_stats', 'ice_hockey_defensive_stat', 'Shots allowed', 'shots_allowed', NULL, 'ice hockey', 'PP GA', 1);


