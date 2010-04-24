
module LeadersModule

  #################################################################################
  # Description:
  #   Get the leaders for a given basketball team
  #
  # Parameters:
  #   -team_id - int - id of the team to get the leaders for
  #   -order - string - SQL statement for the order to return results in. This should be the table's 
  #                     column name for which you want the leaders. If the column is a number you need
  #                     to add '+ 0' to the order string. (e.g. "points_scored_per_game + 0 DESC")
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #   -limit - int - number of results to return
  #                 NOTE: This is an optional parameter that defaults to 50
  #
  # Return:
  #   :select => "person_phases.membership_id AS team_id, display_names.*, 
  #               basketball_offensive_stats.*, basketball_defensive_stats.*, 
  #               basketball_rebounding_stats.*, core_stats.events_played, 
  #               core_stats.time_played_total, person_phases.person_id"
  #############################################################################
  def self.get_basketball_leaders(team_id, order, time=TIME, limit=50, publisher_id=PUBLISHER_ID)
  
    time = time_to_datetime(time)
  
    league = Team.get_league(team_id)
                         
              
    return PersonPhase.find(
              :all,
              :select => "person_phases.membership_id AS team_id, display_names.*, basketball_offensive_stats.*, basketball_defensive_stats.*, basketball_rebounding_stats.*, core_stats.events_played, core_stats.time_played_total, person_phases.person_id",
              :joins => "
              INNER JOIN persons ON persons.id = person_phases.person_id AND persons.publisher_id = #{publisher_id}
              INNER JOIN teams ON teams.id = person_phases.membership_id AND teams.id = #{team_id}
              INNER JOIN positions ON positions.id = person_phases.regular_position_id
              INNER JOIN seasons ON seasons.league_id = #{league.affiliation_id} AND seasons.start_date_time < '#{time}' AND seasons.end_date_time > '#{time}'
              INNER JOIN stats AS off_stats ON off_stats.stat_holder_type = 'persons' AND off_stats.stat_holder_id = person_phases.person_id AND off_stats.stat_coverage_id = seasons.id AND off_stats.stat_repository_type = 'basketball_offensive_stats'
              INNER JOIN basketball_offensive_stats ON basketball_offensive_stats.id = off_stats.stat_repository_id
              INNER JOIN stats AS reb_stats ON reb_stats.stat_holder_type = 'persons' AND reb_stats.stat_holder_id = person_phases.person_id AND reb_stats.stat_coverage_id = seasons.id AND reb_stats.stat_repository_type = 'basketball_rebounding_stats' 
              INNER JOIN basketball_rebounding_stats ON basketball_rebounding_stats.id = reb_stats.stat_repository_id  
              INNER JOIN stats AS def_stats ON def_stats.stat_holder_type = 'persons' AND def_stats.stat_holder_id = person_phases.person_id AND def_stats.stat_coverage_id = seasons.id AND def_stats.stat_repository_type = 'basketball_defensive_stats' 
              INNER JOIN basketball_defensive_stats ON basketball_defensive_stats.id = def_stats.stat_repository_id
              INNER JOIN stats AS c_stats ON c_stats.stat_holder_type = 'persons' AND c_stats.stat_holder_id = person_phases.person_id AND c_stats.stat_coverage_id = seasons.id AND c_stats.stat_repository_type = 'core_stats' 
              INNER JOIN core_stats ON core_stats.id = c_stats.stat_repository_id
              INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'",
              :conditions => "person_phases.membership_type = 'teams' AND display_names.entity_type = 'persons'",
              :order => order,
              :limit => limit)
              

  
  end
  
  
  #################################################################################
  # Description:
  #   Get the leaders for a given ice hockey team
  #
  # Parameters:
  #   -team_id - int - id of the team to get the leaders for
  #   -order - string - SQL statement for the order to return results in. This should be the table's 
  #                     column name for which you want the leaders. If the column is a number you need
  #                     to add '+ 0' to the order string. (e.g. "points_scored_per_game + 0 DESC")
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #   -limit - int - number of results to return
  #                 NOTE: This is an optional parameter that defaults to 50
  #
  # Return:
  #   :select => :select => "person_phases.membership_id AS team_id, display_names.*,
  #                          ice_hockey_offensive_stats.*, ice_hockey_defensive_stats.*,
  #                          person_phases.person_id",
  #############################################################################
  def self.get_ice_hockey_leaders(team_id, order, time=TIME, limit=50, publisher_id=PUBLISHER_ID)
  
    time = time_to_datetime(time)
  
    league = Team.get_league(team_id)
                         
              
    return PersonPhase.find(
              :all,
              :select => "person_phases.membership_id AS team_id, 
                          display_names.*, 
                          ice_hockey_offensive_stats.*, 
                          ice_hockey_defensive_stats.*,
                          ice_hockey_player_stats.plus_minus, 
                          person_phases.person_id",
              :joins => "
              INNER JOIN persons ON persons.id = person_phases.person_id AND persons.publisher_id = #{publisher_id}
              INNER JOIN teams ON teams.id = person_phases.membership_id AND teams.id = #{team_id}
              INNER JOIN positions ON positions.id = person_phases.regular_position_id
              INNER JOIN seasons ON seasons.league_id = #{league.affiliation_id} AND seasons.start_date_time < '#{time}' AND seasons.end_date_time > '#{time}'
              INNER JOIN stats AS off_stats ON off_stats.stat_holder_type = 'persons' AND off_stats.stat_holder_id = person_phases.person_id AND off_stats.stat_coverage_id = seasons.id AND off_stats.stat_repository_type = 'ice_hockey_offensive_stats'
              INNER JOIN ice_hockey_offensive_stats ON ice_hockey_offensive_stats.id = off_stats.stat_repository_id
              INNER JOIN stats AS def_stats ON def_stats.stat_holder_type = 'persons' AND def_stats.stat_holder_id = person_phases.person_id AND def_stats.stat_coverage_id = seasons.id AND def_stats.stat_repository_type = 'ice_hockey_defensive_stats' 
              INNER JOIN ice_hockey_defensive_stats ON ice_hockey_defensive_stats.id = def_stats.stat_repository_id
              INNER JOIN stats AS player_stats ON player_stats.stat_holder_type = 'persons' AND player_stats.stat_holder_id = person_phases.person_id AND player_stats.stat_coverage_id = seasons.id AND player_stats.stat_repository_type = 'ice_hockey_player_stats' 
              INNER JOIN ice_hockey_player_stats ON ice_hockey_player_stats.id = def_stats.stat_repository_id
              INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'",
              :conditions => "person_phases.membership_type = 'teams' AND display_names.entity_type = 'persons'",
              :order => order,
              :limit => limit)
  
  end





end
