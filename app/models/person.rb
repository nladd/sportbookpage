class Person < ActiveRecord::Base
  
  set_table_name "persons"
  
  validates_presence_of :person_key
  validates_length_of :person_key, :allow_nil => false, :maximum => 100
  validates_length_of :gender, :allow_nil => true, :maximum => 20
  validates_length_of :birth_date, :allow_nil => true, :maximum => 30
  validates_length_of :death_date, :allow_nil => true, :maximum => 30
  
  
  #############################################################################
  # Description:
  #   Get a player's basic information 
  #
  # Params:
  #   -person_id - int - id of the player to get information for
  #
  # Return:
  #   :select => "display_names.*, display_names.full_name AS f_name, 
  #         (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name,
  #         person_phases.*, persons.*, persons.id AS person_id, 
  #         positions.abbreviation AS position"
  #   
  #############################################################################
  def self.get_player(person_id, publisher_id = PUBLISHER_ID)
  
    return PersonPhase.find_by_person_id(
                person_id,
                :select => "display_names.*, display_names.full_name AS f_name, (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name, person_phases.*, persons.*, persons.id AS person_id, positions.abbreviation AS position",
                :joins => "INNER JOIN persons ON persons.id = person_phases.person_id INNER JOIN positions ON positions.id = person_phases.regular_position_id  INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'",
                :conditions => "persons.publisher_id = #{publisher_id}")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get a player's card information 
  #
  # Params:
  #   -person_id - int - id of the player to get information for
  #
  # Return:
  #   :select => "display_names.*, display_names.full_name AS f_name, 
  #         (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name,
  #         person_phases.*, persons.*, persons.id AS person_id, 
  #         positions.abbreviation AS position"
  #   
  #############################################################################
  def self.get_card(person_id, time = TIME, publisher_id = PUBLISHER_ID)
  
    team = Person.get_team(person_id)
    league = Team.get_league(team.team_id)
    sport = Affiliation.get_sport_by_league_id(league.affiliation_id)
    sport_name = (sport.full_name).downcase
    
        
    stats_tables = StatsMapping.get_stats_tables("position", sport_name)
    stats_fields = StatsMapping.get_stats_fields("position", sport_name)
    
    select = ""
    joins = ""
    
    stats_tables.each do |table|

      select += ", #{table.stats_table}.*"
      
      joins += " INNER JOIN stats AS stats_#{table.stats_table} ON stats_#{table.stats_table}.stat_holder_type = 'persons' AND stats_#{table.stats_table}.stat_holder_id = person_phases.person_id AND stats_#{table.stats_table}.stat_coverage_id = seasons.id AND stats_#{table.stats_table}.stat_repository_type = '#{table.stats_table}' 
              INNER JOIN #{table.stats_table} ON #{table.stats_table}.id = stats_#{table.stats_table}.stat_repository_id"
    
    end

logger.info "SELECT = " + select
logger.info "JOINS = " + joins


    time = time_to_datetime(time) 

  
    return PersonPhase.find_by_person_id(
                person_id,
                :select => "display_names.*, display_names.full_name AS f_name, (CONCAT(display_names.first_name, ' ', display_names.last_name)) AS full_name, person_phases.*, persons.*, persons.id AS person_id, positions.abbreviation AS position #{select}",
                :joins => "INNER JOIN persons ON persons.id = person_phases.person_id 
                          INNER JOIN positions ON positions.id = person_phases.regular_position_id  
                          INNER JOIN display_names ON display_names.entity_id = persons.id AND entity_type = 'persons'
                          INNER JOIN seasons ON seasons.league_id = #{league.affiliation_id} AND seasons.start_date_time < '#{time}' AND seasons.end_date_time > '#{time}'
                          #{joins}",
                :conditions => "persons.publisher_id = #{publisher_id}")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get a player's team
  #
  # Params:
  #   -person_id - int - id of the player to get the team for
  #   -publisher_id - int - id of the publisher
  #              NOTE: This is an optional paramter that defaults to PUBLISHER_ID
  #
  # Return:
  #   :select => "persons.id AS person_id, display_names.*, pp.team_id"
  #
  #############################################################################
  def self.get_team(person_id, publisher_id = PUBLISHER_ID)
  
    return Person.find(
              person_id, 
              :select => "persons.id AS person_id, display_names.*, pp.membership_id AS team_id",
              :joins => "INNER JOIN person_phases AS pp ON pp.person_id = persons.id AND pp.membership_type = 'teams'
                        INNER JOIN display_names ON display_names.entity_id = pp.membership_id AND display_names.entity_type = 'teams'",
               :conditions => "persons.publisher_id = #{publisher_id}")
  
  end

  
   ############################################################################
  # Description:
  #   Get a person's cumulative stats for a game
  #
  # Params:
  #   -person_id - the id of the person to get the stats for
  #   -event_id - the id of the game to get the stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - 
  ##############################################################################
  def self.get_event_stats(person_id, event_id, repository_type)
  
    return Stat.find_by_stat_holder_id_and_stat_repository_type_and_stat_coverage_id(
            person_id, repository_type, event_id,
            :select => "display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = #{person_id} AND display_names.entity_type = 'persons')",
            :conditions => "stats.stat_coverage_type = 'events'")
  end
  
  
   ##############################################################################
  # Description:
  #   Get a person's cumulative stats for a season
  #
  # Params:
  #   -person_id - the id of the person to get stats for
  #   -sub_season_id - the id of the sub_season to get stats for
  #   -repository_type - the type/name of the table of stats to get
  #
  # Return:
  # -Stat[] - 
  ##############################################################################
  def self.get_season_stats(person_id, sub_season_id, repository_type)
  
    return Stat.find_by_stat_holder_id_and_stat_repository_type_and_stat_coverage_id(
            person_id, repository_type, sub_season_id,
            :select => "display_names.*_name, #{repository_type}.*",
            :joins => "INNER JOIN #{repository_type} ON (#{repository_type}.id = stats.stat_repository_id) 
                       INNER JOIN display_names  ON (display_names.entity_id = #{person_id} AND display_names.entity_type = 'persons')",
            :conditions => "stats.stat_coverage_type = 'sub_seasons'")
  end
  
end
