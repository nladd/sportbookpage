
require 'rubygems'
require 'xml/libxml'
require 'model_helpers'
require 'leaders_module'

###############################################################################
# Description:
#   Models a Team as stored in the database. Also provides help methods to perform
#   queries for Team objects
#
###############################################################################
class Team < ActiveRecord::Base
  
  include LeadersModule
  
  has_many :team_phases, :class_name => "TeamPhase", :foreign_key => "team_id"
  has_many :person_phases, :class_name => "PersonPhase", :foreign_key => "membership_id"
  

  validates_presence_of :team_key
  validates_length_of :team_key, :allow_nil => false, :maximum => 100
  
  #############################################################################
  # Description:
  #   Get a team's roster from the team's id
  #
  # Params:
  #   -team_id - id - the id of the team is defined by the id attribute in the teams table 
  #   -order - string - SQL string defining the oder to return the resutls
  #                     Note: This is an optional parameter and defaults to:
  #                           "person_phases.uniform_number + 0 ASC"
  #   -publisher_id - int - id pf the publisher for the data
  #                       NOTE: This is an optional parameter that defaults to the PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "display_names.*, person_phases.*, 
  #               persons.*, persons.id AS person_id, positions.abbreviation AS position"
  ##############################################################################
  def self.get_roster(team_id, order = nil, publisher_id = PUBLISHER_ID)
  
    if (order == nil)
      order = "person_phases.uniform_number + 0 ASC"
    end
  
    return PersonPhase.find(
              :all,
              :select => "display_names.*, display_names.full_name AS f_name, (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name, person_phases.*, persons.*, persons.id AS person_id, positions.abbreviation AS position",
              :joins => "
              INNER JOIN persons ON persons.id = person_phases.person_id
              INNER JOIN teams ON teams.id = person_phases.membership_id
              INNER JOIN positions ON positions.id = person_phases.regular_position_id
              INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'",
              :conditions => "person_phases.membership_type = 'teams' AND display_names.entity_type = 'persons' AND persons.publisher_id = #{publisher_id} AND teams.id = #{team_id} AND person_phases.phase_status != 'inactive'",
              :order => order)
              
              
  end 
  
  
   ##############################################################################
  # Description:
  #   Get a team's games and individual game information for a specific date range 
  #   including game date, time, location (home/away), opponent id, and opponent score of a single team.
  #
  # Params:
  #   -team_id - int - team for which to get the scheule as specified by the team_id as defined
  #              by the id attribute of the 'teams' table
  #   -range_start - - Time - the start date of the range
  #   -range_end - Time - the end date of the range
  #   -order - String - sql syntax for an ORDER statement to sort the results 
  #            Note: This is an optional field that defaults to "events.start_date_time ASC"
  #
  # Return:
  # -games[] - Array of objects of type ParticipantsEvent[].Events
  #           :select => "display_names.abbreviation, display_names.*_name, display_names.url, t2.*,
  #             events.start_date_time"
  #
  ##############################################################################
  def self.get_games_by_date_range(team_id, range_start, range_end, order = nil)
  
    start_date = time_to_datetime(range_start)
    end_date = time_to_datetime(range_end)

    if order.blank?
      order = "events.start_date_time ASC"
    end
  
    return ParticipantsEvent.find(
                  :all, 
                  :select => "display_names.abbreviation, display_names.*_name, display_names.url, t2.*, CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
                  :from => "participants_events AS t1",
                  :joins => "INNER JOIN participants_events AS t2 ON (t2.participant_id <> t1.participant_id AND t2.event_id = t1.event_id)
                             INNER JOIN display_names ON display_names.entity_id = t2.participant_id AND display_names.entity_type = 'teams'
                             INNER JOIN events ON events.id = t1.event_id AND events.id = t2.event_id",
                  :conditions => "t1.participant_id = #{team_id} AND events.start_date_time >= '#{start_date}' AND events.start_date_time <= '#{end_date}'",                                    
                  :order => order)
  end
  
 
   
  
  ##############################################################################
  # Description:
  #   Get a the next n number of games for a given team
  #
  # Params:
  #   -team_id - int - team for which to get the scheule as specified by the 
  #   -range_start - Time - the start date from which to get the next n games
  #                   Note: This is an optional parameter that defaults to the TIME env variable
  #   -limit - int - the number of results to return as determined by the LIMIT SQL statement
  #                   Note: This is an optional parameter that defaults to 20
  #   -order - String - sql syntax for an ORDER statement to sort the results 
  #                     Note: This is an optional field that defaults to "events.start_date_time ASC"
  #
  # Return:
  #            :select => "
  #                        display_names.abbreviation AS abbr, 
  #                        display_names.entity_id AS id,
  #                        display_names.first_name AS first_name,
  #                        display_names.last_name AS last_name,
  #                        display_names.full_name AS full_name,
  #                        display_names.alias AS alias,
  #                        display_names.url AS url,
  #                        t1.alignment AS t1_alignment,
  #                        t1.score AS t1_score,
	#		                    t1.event_outcome AS t1_outcome,
  #                        t2.alignment AS t2_alignment,
  #                        t2.score AS t2_score, 
 	#		                    t2.event_outcome AS t2_outcome,
 	#		                    events.id AS event_id,
 	#		                    events.event_status,
 	#		                    events.broadcast_listing,
 	#		                    CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
  #
  ##############################################################################
  def self.get_next_n_games(team_id, limit = 20, range_start = TIME, order = nil)
  
    range_start = time_to_datetime(range_start)

    if order.blank?
      order = "events.start_date_time ASC"
    end
                
                  
    games = ParticipantsEvent.find(
              :all,
              :select => "
                          d2.abbreviation AS opponent_abbr, 
                          d2.entity_id AS opponent_id,
                          d2.first_name AS opponent_first_name,
                          d2.last_name AS opponent_last_name,
                          d2.full_name AS opponent_full_name,
                          d2.alias AS opponent_alias,
                          d2.url AS opponent_url,
                          t1.alignment AS t1_alignment,
                          t1.score AS t1_score,
			                    t1.event_outcome AS t1_outcome,
			                    t2.participant_id AS opponent_id,
                          t2.alignment AS t2_alignment,
                          t2.score AS t2_score, 
 			                    t2.event_outcome AS t2_outcome,
 			                    events.id AS event_id,
 			                    events.event_status,
 			                    events.broadcast_listing,
                          CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
               :from => "participants_events AS t1",
               :joins => "INNER JOIN events ON events.id = t1.event_id
			 INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                         INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "t1.participant_id = #{team_id} AND events.start_date_time >= '#{range_start}' AND t1.event_id = events.id AND t1.participant_type = 'teams'",                                    
              :order => order,
              :limit => limit)
                  
                  

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end  

    return games

  end
  
  
  ##############################################################################
  # Description:
  #   Get a the previous n number games for a given team
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to get the scheule as specified by the 
  #             affiliation_id as defined by the id attribute of the 'affiliations' table
  #   -range_end - Time - time from which to get the previous games
  #                   Note: This is an opptional paramter that defaults to the TIME env variable
  #   -limit - int - the number of results to return as determined by the LIMIT SQL statement
  #                   Note: This is an optional parameter that defaults to 20
  #   -order - String - sql syntax for an ORDER statement to sort the results 
  #                     Note: This is an optional field that defaults to "events.start_date_time DESC"
  #
  # Return:
  # -games[] - Array of objects of type AffiliationsEvent
  #            :select => "d1.abbreviation AS t1_abbr, 
  #                        d1.entity_id AS t1_id,
  #                        d1.first_name AS t1_first_name,
  #                        d1.last_name AS t1_last_name,
  #                        d1.full_name AS t1_full_name,
  #                        d1.url AS t1_url,
  #                        d2.abbreviation AS t1_abbr, 
  #                        d2.entity_id AS t2_id,
  #                        d2.first_name AS t2_first_name,
  #                        d2.last_name AS t2_last_name,
  #                        d2.full_name AS t2_full_name,
  #                        d2.url AS t2_url,
  #                        t1.alignment AS t1_alignment,
  #                        t1.score AS t1_score,
  #                        t2.alignment AS t2_alignment,
  #                        t2.score AS t2_score,
  #                        events.broadcast_listing,
  #                        events.start_date_time"
  #
  ##############################################################################
  def self.get_previous_n_games(team_id, limit = 20, range_end = TIME, order = nil)
  
    range_end = time_to_datetime(range_end)

    if order.blank?
      order = "events.start_date_time DESC"
    end
  
    games = ParticipantsEvent.find(
              :all,
              :select => "d2.abbreviation AS opponent_abbr, 
                          d2.entity_id AS opponent_id,
                          d2.first_name AS opponent_first_name,
                          d2.last_name AS opponent_last_name,
                          d2.full_name AS opponent_full_name,
                          d2.alias AS opponent_alias,
                          d2.url AS opponent_url,
                          t1.alignment AS t1_alignment,
                          t1.score AS t1_score,
			                    t1.event_outcome AS t1_outcome,
			                    t2.participant_id AS opponent_id,
                          t2.alignment AS t2_alignment,
                          t2.score AS t2_score, 
 			                    t2.event_outcome AS t2_outcome,
 			                    events.id AS event_id,
 			                    events.event_status,
 			                    events.broadcast_listing,
                          CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
               :from => "participants_events AS t1",
               :joins => "INNER JOIN events ON events.id = t1.event_id
			 INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                         INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "t1.participant_id = #{team_id} AND events.start_date_time <= '#{range_end}' AND t1.event_id = events.id AND t1.participant_type = 'teams'",                                    
              :order => order,
              :limit => limit)

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end  

    return games

  end
  

   ##############################################################################
  # Description:
  #   Get a team's cumulative stats for a game
  #
  # Params:
  #   -team_id - the team's id to get the game stats for
  #   -event_id - the id of the game to get the stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - 
  ##############################################################################
  def self.get_event_stats(team_id, event_id, repository_type)
  
    return Stat.find_by_stat_holder_id_and_stat_repository_type_and_stat_coverage_id(
            team_id, repository_type, event_id,
            :select => "display_names.abbreviation, display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = #{team_id} AND display_names.entity_type = 'teams')",
            :conditions => "stats.stat_coverage_type = 'events'")
  end
  
   ##############################################################################
  # Description:
  #   Get a team's cumulative stats for a season
  #
  # Params:
  #   -team_id - the team's id to get the game stats for
  #   -sub_season_id - the id of the subb_season to get the stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - 
  ##############################################################################
  def self.get_season_stats(team_id, sub_season_id, repository_type)
  
    return Stat.find_by_stat_holder_id_and_stat_repository_type_and_stat_coverage_id(
            team_id, repository_type, sub_season_id,
            :select => "display_names.abbreviation, display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = #{team_id} AND display_names.entity_type = 'teams')",
            :conditions => "stats.stat_coverage_type = 'sub_seasons'")
  end
  
   ##############################################################################
  # Description:
  #   Get each individual player's stats of the entire team for a single game
  #
  # Params:
  #   -team_id - the id of the team to get the stats for
  #   -event_id - the id of the game to get the stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - Only player's with recorded stats will be returned
  #
  ##############################################################################
  def self.get_players_event_stats(team_id, event_id, repository_type)
  
    return Stat.find_all_by_stat_repository_type_and_stat_coverage_id(
            repository_type, event_id,
            :select => "display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = stats.stat_holder_id AND display_names.entity_type = 'persons')
                       INNER JOIN person_phases ON (person_phases.membership_id = #{team_id} AND person_phases.person_id = stats.stat_holder_id)",
            :conditions => "stats.stat_coverage_type = 'events'")
  end
  
  
   ##############################################################################
  # Description:
  #   Get each individual player's cumulative stats of the entire team for an entire season
  #
  # Params:
  #   -team_id - the id of the team to get the stats for
  #   -sub_season_id - the id of the sub_season to get the stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - Only player's with recorded stats will be returned
  #
  ##############################################################################
  def self.get_players_season_stats(team_id, sub_season_id, repository_type)
  
    return Stat.find_all_by_stat_repository_type_and_stat_coverage_id(
            repository_type, sub_season_id,
            :select => "display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = stats.stat_holder_id AND display_names.entity_type = 'persons')
                       INNER JOIN person_phases ON (person_phases.membership_id = #{team_id} AND person_phases.person_id = stats.stat_holder_id)",
            :conditions => "stats.stat_coverage_type = 'sub_seasons'")
  end
  
  
  ###############################################################################
  # Description:
  #   The leaders for a given team
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
  #   
  #############################################################################
  def self.get_leaders(team_id, stats_field, time=TIME, 
                                    limit=50, publisher_id=PUBLISHER_ID)
    
    league = Team.get_league(team_id)
    sport = Affiliation.get_sport_by_league_id(league.affiliation_id)
    sport_name = (sport.full_name).downcase
    
    stat = StatsMapping.find_by_stats_field_and_sport(stats_field, sport_name)
    
    stats_tables = StatsMapping.get_stats_tables(stat.stats_type, sport_name)
    stats_fields = StatsMapping.get_stats_fields(stat.stats_type, sport_name)
    
    select_statement = ""
    join_statement = ""
    
    stats_tables.each do |table|
      
      stats_fields = StatsMapping.find_all_by_stats_table_and_stats_type(
                                      table.stats_table, stat.stats_type)

      stats_fields.each do |field|
        select_statement += ", #{table.stats_table}.#{field.stats_field}"
      end
      
      join_statement += " INNER JOIN stats AS stats_#{table.stats_table} ON stats_#{table.stats_table}.stat_holder_type = 'persons' AND stats_#{table.stats_table}.stat_holder_id = person_phases.person_id AND stats_#{table.stats_table}.stat_coverage_id = sub_seasons.id AND stats_#{table.stats_table}.stat_repository_type = '#{table.stats_table}' AND stats_#{table.stats_table}.stat_membership_id = teams.id AND stats_#{table.stats_table}.stat_membership_type = 'teams'
              INNER JOIN #{table.stats_table} ON #{table.stats_table}.id = stats_#{table.stats_table}.stat_repository_id"
    
    end

    season_key = time.year + 1
    season = nil
    while (season.blank?) 
      season_key = season_key - 1
      season = Season.find_by_season_key_and_league_id(season_key, league.affiliation_id)
    end
              
    return PersonPhase.find(
              :all,
              :select => "person_phases.membership_id AS team_id, display_names.*, display_names.full_name AS f_name, (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name, core_stats.events_played, core_stats.time_played_total, person_phases.person_id" + select_statement,
              :joins => "
              INNER JOIN persons ON persons.id = person_phases.person_id AND persons.publisher_id = #{publisher_id}
              INNER JOIN teams ON teams.id = person_phases.membership_id AND teams.id = #{team_id}
              INNER JOIN positions ON positions.id = person_phases.regular_position_id
              INNER JOIN seasons ON seasons.league_id = #{league.affiliation_id} AND seasons.season_key = #{season_key}
              INNER JOIN sub_seasons ON sub_seasons.season_id = seasons.id AND sub_seasons.sub_season_type = 'season-regular'
              INNER JOIN stats AS c_stats ON c_stats.stat_holder_type = 'persons' AND c_stats.stat_holder_id = person_phases.person_id AND c_stats.stat_coverage_id = sub_seasons.id AND c_stats.stat_repository_type = 'core_stats' AND c_stats.stat_membership_id = teams.id AND c_stats.stat_membership_type = 'teams'
              INNER JOIN core_stats ON core_stats.id = c_stats.stat_repository_id
              INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'" + join_statement,
              :conditions => "person_phases.membership_type = 'teams' AND person_phases.phase_status != 'inactive'",
              :order => "#{stat.stats_table}.#{stats_field} + 0 DESC",
              :limit => limit)

  
  end

  
  #############################################################################
  # Description:
  #   Get basic information about a team
  #
  # Params:
  #   -team_id - int - id of the team to get information for
  #
  # Return:
  #   :select => "display_names.*, display_names.entity_id AS team_id"
  #############################################################################
  def self.get_team(team_id)
  
    return DisplayName.find_by_entity_id(
            team_id,
            :select => "display_names.*, display_names.entity_id AS team_id", 
            :conditions => "entity_type = 'teams'")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get the league that a team belongs to
  #
  # Params:
  #   -team_id - int - id of the team to get the league for
  #
  # Return:
  #   :select => "display_names.*, team_phases.affiliation_id",
  #############################################################################
  def self.get_league(team_id)
  
    return TeamPhase.find_by_team_id(
                        team_id,
                        :select => "display_names.*, team_phases.affiliation_id",
                        :joins => "INNER JOIN affiliations ON affiliations.id = team_phases.affiliation_id
                                   INNER JOIN display_names ON display_names.entity_id = team_phases.affiliation_id",
                        :conditions => "affiliations.affiliation_type = 'league' AND display_names.entity_type = 'affiliations'")
  
  end
  
  
  #############################################################################
  # Description:
  #  Determine if a team is in a user's profile or not.
  #
  # Params:
  #  -league_id - int - id of the league the team belongs to
  #  -team_id - int - id of the team
  #  -user_id - int - id of the user
  #
  # Return:
  #  True is the league is in the user's profile, false if not
  #############################################################################
  def self.team_is_in_profile(league_id, team_id, user_id)
    path = RAILS_ROOT + "/public/users/#{user_id}/#{user_id}.profile"
    parser = XML::Parser.file(path)
    profile = parser.parse

    pro_sports = profile.find('//root/sports/sport')
    pro_sports = pro_sports.to_a
    college_sports = profile.find('//root/sports/collegeSports/sport')
    college_sports = college_sports.to_a
    
    sports = pro_sports.concat(college_sports)

    sports.each do |sport|
      if(sport['id'].to_i == league_id.to_i)

	      teams = sport.children
	      teams.each do |team|
	        if ( team['id'].to_i == team_id.to_i )
	          return true
	        end
	      end
	      
      end
    end
     
    return false
  end
  
  

  
  

  
  
  
  
end
