
require 'rubygems'
require 'xml/libxml'
require 'model_helpers.rb'

class Affiliation < ActiveRecord::Base

  has_many :person_phases, :class_name => "PersonPhase", :foreign_key => "membership_id"
  has_many :standing_subgroups, :class_name => "StandingSubgroup", :foreign_key => "affiliation_id"
  has_many :standings, :class_name => "Standing", :foreign_key => "affiliation_id"

  validates_presence_of :affiliation_key
  validates_length_of :affiliation_key, :allow_nil => false, :maximum => 100
  validates_length_of :affiliation_type, :allow_nil => true, :maximum => 100
  
  
  
  #############################################################################
  # Description:
  #   Get all the sports within the database
  #
  # Parameters:
  #     -publisher_id - int - id of the publisher to use
  #                           Note: This is an optional parameter that defaults to 1
  #
  # Return:
  #   :select => affiliations.id, affiliations.affiliation_key, affiliations.affiliation_type,
  #             display_names.full_name
  #############################################################################
  def self.get_sports(publisher_id = PUBLISHER_ID)
    
    return Affiliation.find(
                        :all,
                        :select => "affiliations.id, affiliations.affiliation_key, affiliations.affiliation_type, display_names.full_name",
                        :joins => "INNER JOIN display_names ON display_names.entity_id = affiliations.id",
                        :conditions => "affiliations.affiliation_type = 'sport' AND display_names.entity_type = 'affiliations' AND affiliations.publisher_id = " + publisher_id.to_s)
                        
  end


  #############################################################################
  # Description:
  #   Get all the covered sports
  #
  # Parameters:
  #     -publisher_id - int - id of the publisher to use
  #         Note: This is an optional parameter that defaults to PUBLISHER_ID
  #
  # Return:
  #
  # Return:
  #   :select => affiliations.id AS affiliation_id, affiliations.affiliation_key, 
  #              affiliations.affiliation_type, display_names.full_name
  #############################################################################
  def self.get_covered_sports(publisher_id = PUBLISHER_ID)
    
    return DisplayName.find_all_by_full_name(
                        SPORTS,
                        :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, affiliations.affiliation_type, display_names.full_name",
                        :joins => "INNER JOIN affiliations ON affiliations.id = display_names.entity_id",
                        :conditions => "affiliations.affiliation_type = 'sport' AND display_names.entity_type = 'affiliations' AND affiliations.publisher_id = " + publisher_id.to_s)
                        
  end  

  
  #############################################################################
  # Description:
  #   Get the sport a league belongs to by league id
  #
  # Params:
  #   -league_id - int - id of the league
  #
  # Return:
  #
  #############################################################################
  def self.get_sport_by_league_id(league_id)
  
    return AffiliationPhase.find_by_affiliation_id(
                league_id,
                :select => "*",
                :joins => "INNER JOIN display_names ON display_names.entity_id = affiliation_phases.ancestor_affiliation_id AND display_names.entity_type = 'affiliations'")
                
  
  end
  
  
  ##############################################################################
  # Description:
  #   Gets the leagues in the database for a given sport
  #
  # Paramas:
  #   -sport_id - int - id of the sport to get the leagues for
  #   -order - string - sql ORDER statement to format results
  #                     Note: This is an optional parameter that defaults to "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to 1
  #
  # Return:
  #   :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, display_names.*_name,    
  #                           display_names.abbreviation, display_names.url"
  ##############################################################################
  def self.get_leagues_by_sport(sport_id, order = nil, publisher_id = PUBLISHER_ID)
    if order.blank?
      order = "display_names.abbreviation ASC"
    end

    
    return Affiliation.find_all_by_affiliation_type(
              "league",
              :select => "affiliations.id AS affiliation_id,  affiliations.affiliation_type, display_names.*_name, display_names.abbreviation, display_names.url",
              :joins => "INNER JOIN display_names ON display_names.entity_id = affiliations.id AND display_names.entity_type = 'affiliations'
                         INNER JOIN affiliation_phases ON affiliation_phases.ancestor_affiliation_id = " + sport_id.to_s + " AND affiliation_phases.affiliation_id = affiliations.id",
              :conditions => "affiliations.affiliation_type = 'league' AND affiliations.publisher_id = " + publisher_id.to_s,
              :order => order)
  
  end
  
   
  
  #############################################################################
  # Description:
  #   Get the conferences of a leauge
  #
  # Params:
  #   -leauge_id - int - the id of the leauge to get the conferences for
  #   -order - string - sql ORDER statement to format results
  #        Note: This is an optional parameter. Default: "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #        Note: This is an optional parameter. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, 
  #               affiliations.affiliation_type, display_names.*_name, display_names.abbreviation"
  #############################################################################
  def self.get_conferences_by_league(league_id, order = nil, publisher_id = PUBLISHER_ID)
    if order.blank?
      order = "display_names.full_name ASC"
    end
    
    return Affiliation.find_all_by_affiliation_type(
                        "conference",
                        :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, affiliations.affiliation_type, display_names.*_name, display_names.abbreviation",
                        :joins => "INNER JOIN affiliation_phases ON affiliation_phases.ancestor_affiliation_id = #{league_id} AND affiliation_phases.affiliation_id = affiliations.id
                                  INNER JOIN display_names ON display_names.entity_id = affiliations.id AND display_names.entity_type = 'affiliations'",
                        :conditions => "affiliations.publisher_id = " + publisher_id.to_s,
                        :order => order)
  
  end
  
  
  #############################################################################
  # Description:
  #   Get the divisions of a league
  #
  # Params:
  #   -league_id - int - the id of the league to get the divisions for
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to 1
  #
  # Return:
  #   :select => "divisions.id AS affiliation_id, display_names.*"
  #
  #############################################################################
  def self.get_divisions_by_league(league_id, publisher_id = PUBLISHER_ID)   
  
    return AffiliationPhase.find_all_by_root_id(
                        league_id,
                        :select => "divisions.id AS affiliation_id, display_names.*, conference_dn.full_name AS conference_name",
                        :joins => "INNER JOIN affiliations AS divisions ON affiliation_phases.affiliation_id = divisions.id AND divisions.affiliation_type = 'division'  
                                   INNER JOIN display_names ON (display_names.entity_id = divisions.id) AND display_names.entity_type = 'affiliations'     
                                   INNER JOIN affiliations AS conferences ON conferences.affiliation_type = 'conference'  
                                   INNER JOIN affiliation_phases AS conference_ap ON conference_ap.root_id = #{league_id} AND conference_ap.ancestor_affiliation_id = conferences.id AND conference_ap.affiliation_id = divisions.id 
                                   INNER JOIN display_names AS conference_dn ON (conference_dn.entity_id = conferences.id) AND conference_dn.entity_type = 'affiliations'",
                        :conditions => "divisions.publisher_id = #{publisher_id} AND conferences.publisher_id = #{publisher_id} AND affiliation_phases.ancestor_affiliation_id = conferences.id",
                        :order => "conference_name, display_names.full_name ASC")
                        



  end
  
  #############################################################################
  # Description:
  #   Get the divisions of a conference
  #
  # Params:
  #   -conference_id - int - the id of the conference to get the leagues for
  #   -order - string - sql ORDER statement to format results
  #                     Note: This is an optional parameter that defaults to "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to 1
  #
  # Return:
  #   :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, 
  #               affiliations.affiliation_type, display_names.*_name, display_names.abbreviation"
  #############################################################################
  def self.get_divisions_by_conference(conference_id, order = nil, publisher_id = nil)
    if order.blank?
      order = "display_names.full_name ASC"
    end
    if publisher_id.blank?
      publisher_id = PUBLISHER_ID
    end
    
    return Affiliation.find_all_by_affiliation_type(
                        "division",
                        :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, affiliations.affiliation_type, display_names.*",
                        :joins => "INNER JOIN affiliation_phases ON affiliation_phases.affiliation_id = affiliations.id AND affiliation_phases.ancestor_affiliation_id = #{conference_id} 
                                   INNER JOIN display_names ON display_names.entity_id = affiliations.id AND display_names.entity_type = 'affiliations'",
                        :conditions => "affiliations.publisher_id = " + publisher_id.to_s,
                        :order => order)
  
  end
  
  #############################################################################
  # Description:
  #   Get the teams of a league
  #
  # Params:
  #   -league_id - int - the id of the league to get the teams for
  #   -affiliation_key - string - affiliation key of the league the teams being returned belong to
  #   -order - string - sql ORDER statement to format results
  #                     Note: This is an optional parameter that defaults to "display_names.full_name ASC"
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to PUBLISHER_ID
  #
  # Return:
  #   :select => "teams.id AS team_id, teams.team_key, display_names.*"
  #############################################################################
  def self.get_teams_by_league(league_id, affiliation_key, 
                                order = "display_names.full_name ASC", 
                                publisher_id = PUBLISHER_ID)

    # college football needs to be treated as a specail case
    if (affiliation_key == "l.ncaa.org.mfoot.div1.aa")
      affiliation_key = "l.ncaa.org.mfoot"
    end
    
    return Affiliation.find_all_by_affiliation_type(
                        "league",
                        :select => "teams.id AS team_id, teams.team_key, display_names.*",
                        :joins => "INNER JOIN teams
                                  INNER JOIN team_phases ON team_phases.team_id = teams.id AND  team_phases.affiliation_id = affiliations.id AND team_phases.affiliation_id = " + league_id.to_s + " 
                                  INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
                        :conditions => "display_names.full_name NOT LIKE '%All-Stars' AND display_names.full_name <> 'To Be Announced' AND teams.team_key LIKE '" + affiliation_key + "%' AND  affiliations.publisher_id = " + publisher_id.to_s,
                        :order => order)
                        
  end   


  #############################################################################
  # Description:
  #   Get the teams of a conference
  #
  # Params:
  #   -conference_id - int - the id of the conference to get the leagues for
  #   -affiliation_key - string - affiliation key of the league the teams being returned belong to
  #   -order - string - sql ORDER statement to format results
  #                     Note: This is an optional parameter that defaults to "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to PUBLISHER_ID
  #
  # Return:
  #   :select => "teams.id AS team_id, teams.team_key, display_names.*_name, display_names.abbreviation"
  #############################################################################
  def self.get_teams_by_conference(conference_id, 
                                   affiliation_key, 
                                   order = nil, publisher_id = PUBLISHER_ID)
    if order.blank?
      order = "display_names.abbreviation ASC"
    end

    # college football needs to be treated as a specail case
    if (affiliation_key == "l.ncaa.org.mfoot.div1.aa")
      affiliation_key = "l.ncaa.org.mfoot"
    end
    
    return Affiliation.find_all_by_affiliation_type(
                        "conference",
                        :select => "teams.id AS team_id, teams.team_key, display_names.*_name, display_names.abbreviation",
                        :joins => "INNER JOIN teams
                                  INNER JOIN team_phases ON team_phases.team_id = teams.id AND  team_phases.affiliation_id = affiliations.id AND team_phases.affiliation_id = " + conference_id.to_s + " 
                                  INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
                        :conditions => "display_names.full_name NOT LIKE '%All-Stars' AND teams.team_key LIKE '" + affiliation_key + "%' AND  affiliations.publisher_id = " + publisher_id.to_s,
                        :order => order)
                        
  end   

  
  #############################################################################
  # Description:
  #   Get the teams of a division
  #
  # Params:
  #   -division_id - int - the id of the division to get the teams for
  #   -affiliation_key - string - affiliation key of the league the teams being returned belong to
  #   -order - string - sql ORDER statement to format results
  #                     Note: This is an optional parameter that defaults to "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #                     Note: This is an optional parameter that defaults to PUBLISHER_ID
  #
  # Return:
  #   :select => "teams.id AS team_id, teams.team_key, display_names.*, display_names.abbreviation",
  #############################################################################
  def self.get_teams_by_division(division_id, affiliation_key, order = nil, publisher_id = PUBLISHER_ID)
    if order.blank?
      order = "display_names.abbreviation ASC"
    end

    # college football needs to be treated as a specail case
    if (affiliation_key == "l.ncaa.org.mfoot.div1.aa")
      affiliation_key = "l.ncaa.org.mfoot"
    end
    
    return Affiliation.find_all_by_affiliation_type(
                        "division",
                        :select => "teams.id AS team_id, teams.team_key, display_names.*, display_names.abbreviation",
                        :joins => "INNER JOIN teams
                                  INNER JOIN team_phases ON team_phases.team_id = teams.id AND  team_phases.affiliation_id = affiliations.id AND team_phases.affiliation_id = " + division_id.to_s + " 
                                  INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
                        :conditions => "teams.team_key LIKE '" + affiliation_key + "%' AND  affiliations.publisher_id = " + publisher_id.to_s,
                        :order => order)
                        
  end                        
                    
  
  ##############################################################################
  # Description:
  #   Gets the professional leagues in the database (e.g. NFL, MLB, NBA...)
  #
  # Params:
  #   -order - String - sql ORDER statement to format results
  #                     This is an optional parameter that defaults to "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #
  # Return:
  #   :select => affiliations.id AS affiliation_id, affiliations.affiliation_key AS affiliation_key,
  #              affiliations.publisher_id, display_names.*
  ##############################################################################
  def self.get_pro_leagues(order = nil, publisher_id = PUBLISHER_ID)
    if order.blank?
      order = "display_names.abbreviation ASC"
    end


    return DisplayName.find_all_by_full_name(
              PROFESSIONAL_LEAGUES,
              :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key AS affiliation_key, affiliations.publisher_id, display_names.*",
              :joins => "INNER JOIN affiliations ON display_names.entity_id = affiliations.id AND affiliations.publisher_id = #{publisher_id}",
              :order => order)
  
  end
 
  
  #############################################################################
  # Description:
  #   Get the college leagues
  #
  # Params:
  #   -order - String - sql ORDER statement to format results
  #         Note: This is an optional parameter. Default: "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #         NOTE: This is an optional parameter. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "affiliations.id AS affiliation_id,
  #               affiliations.affiliation_key AS affiliation_key, 
  #               affiliations.publisher_id, display_names.*",
  #
  #############################################################################
  def self.get_college_leagues(order = nil, publisher_id = PUBLISHER_ID)
  
    if order.blank?
      order = "display_names.abbreviation ASC"
    end

  
    return DisplayName.find_all_by_full_name(
              COLLEGE_LEAGUES,
             :select => "affiliations.id AS affiliation_id,
                         affiliations.affiliation_key AS affiliation_key, 
                         affiliations.publisher_id, display_names.*",
              :joins => "INNER JOIN affiliations ON display_names.entity_id = affiliations.id AND affiliations.publisher_id = #{publisher_id}",
              :order => order)
  
  
  end
  
  
  #############################################################################
  # Description:
  #   Get all leagues
  #
  # Params:
  #   -order - String - sql ORDER statement to format results
  #         Note: This is an optional parameter. Default: "display_names.abbreviation ASC"
  #   -publisher_id - int - id of the publisher to use
  #         NOTE: This is an optional parameter. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "affiliations.id AS affiliation_id,
  #               affiliations.affiliation_key AS affiliation_key, 
  #               affiliations.publisher_id, display_names.*",
  #
  #############################################################################
  def self.get_all_leagues(order = nil, publisher_id = PUBLISHER_ID)
  
    if order.blank?
      order = "display_names.abbreviation ASC"
    end

    return DisplayName.find_all_by_full_name(
              ALL_LEAGUES,
             :select => "affiliations.id AS affiliation_id,
                         affiliations.affiliation_key AS affiliation_key, 
                         affiliations.publisher_id, display_names.*",
              :joins => "INNER JOIN affiliations ON display_names.entity_id = affiliations.id AND affiliations.publisher_id = #{publisher_id}",
              :order => order)
  
  
  end
  
   
 
  #############################################################################
  # Description:
  #  Allows method calls to get_leagues to be forwards compatible
  #
  #############################################################################
  def self.get_leagues
    return get_pro_leagues
  end



 
  ##############################################################################
  # Description:
  #   Gets a league information
  #
  # Paramas:
  #   -league_id - int - id of the leauge to get info for
  #   -publisher_id - int - id of the publisher to use
  #         Note: This is an optional parameter. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "display_names.*, display_names.entity_id AS affiliation_id,
  #               affiliations.*"
  ##############################################################################
  def self.get_league(league_id, publisher_id = PUBLISHER_ID)
  
    return Affiliation.find_by_id(
              league_id,
              :select => "display_names.*, display_names.entity_id AS affiliation_id, affiliations.*",
              :joins => "INNER JOIN display_names ON display_names.entity_id = affiliations.id",
              :conditions => "display_names.entity_type = 'affiliations' AND affiliations.publisher_id = #{publisher_id}")
  
  end

  
  ##############################################################################
  # Description:
  #   Gets a conference's information
  #
  # Paramas:
  #   -conference_id - int - id of the conference to get info for
  #   -publisher_id - int - id of the publisher to use
  #         Note: This is an optional parameter. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "display_names.*, display_names.entity_id AS affiliation_id,
  #               affiliations.*"
  ##############################################################################
  def self.get_conference(conference_id, publisher_id = PUBLISHER_ID)
  
    return Affiliation.find_by_id(
              conference_id,
              :select => "display_names.*, display_names.entity_id AS affiliation_id, affiliations.*",
              :joins => "INNER JOIN display_names ON display_names.entity_id = affiliations.id",
              :conditions => "display_names.entity_type = 'affiliations' AND affiliations.publisher_id  = #{publisher_id}")
  
  end

  
  ##############################################################################
  # Description:
  #   Get a team's games and individual game information for a specific date range 
  #   including game date, time, location (home/away), opponent id, and opponent score of a single team.
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to get the scheule as specified by the 
  #             affiliation_id as defined by the id attribute of the 'affiliations' table
  #   -range_start - - Time - the start date of the range
  #   -range_end - Time - the end date of the range
  #   -order - String - sql syntax for an ORDER statement to sort the results 
  #                     This is an optional field that defaults to "events.start_date_time ASC"
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
  def self.get_games_by_date_range(affiliation_id, range_start, range_end, order = nil)
  
    start_date = time_to_datetime(range_start)
    end_date = time_to_datetime(range_end)

    if order.blank?
      order = "events.start_date_time ASC"
    end
  
    games = AffiliationsEvent.find_all_by_affiliation_id(
              affiliation_id, 
              :select => "d1.abbreviation AS t1_abbr, 
                          d1.entity_id AS t1_id,
                          d1.first_name AS t1_first_name,
                          d1.last_name AS t1_last_name,
                          d1.full_name AS t1_full_name,
                          d1.alias AS t1_alias,
                          d1.url AS t1_url,
                          d2.abbreviation AS t2_abbr, 
                          d2.entity_id AS t2_id,
                          d2.first_name AS t2_first_name,
                          d2.last_name AS t2_last_name,
                          d2.full_name AS t2_full_name,
                          d2.alias AS t2_alias,
                          d2.url AS t2_url,
                          t1.alignment AS t1_alignment,
                          t1.score AS t1_score,
			                    t1.event_outcome AS t1_outcome,
                          t2.alignment AS t2_alignment,
                          t2.score AS t2_score, 
 			                    t2.event_outcome AS t2_outcome,
 			                    events.id AS event_id,
 			                    events.event_status,
 			                    events.broadcast_listing,
                          CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
               :joins => "INNER JOIN events ON events.id = affiliations_events.event_id
			 INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
			 INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                         INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams'
                         INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "events.start_date_time >= '#{start_date}' AND events.start_date_time <= '#{end_date}'",                                    
              :order => order)

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end  

    return games

  end
  
  
  ##############################################################################
  # Description:
  #   Get a team's games and individual game information for a specific date range 
  #   including game date, time, location (home/away), opponent id, and opponent score of a single team.
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to get the scheule as specified by the 
  #             affiliation_id as defined by the id attribute of the 'affiliations' table
  #   -range_start - Time - the start date of the range
  #                   Note: This is an optional parameter that defualts to TIME env variable
  #   -n - int - the number of results to return as determined by the LIMIT SQL statement
  #                   Note: This is an optional parameter that defaults to 20
  #   -order - String - sql syntax for an ORDER statement to sort the results 
  #                     Note: This is an optional field that defaults to "events.start_date_time ASC"
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
  def self.get_next_n_games(affiliation_id, n = 20, range_start = TIME)
  
    start_date = time_to_datetime(range_start)

  
    games = AffiliationsEvent.find_all_by_affiliation_id(
              affiliation_id, 
              :select => "d1.abbreviation AS t1_abbr, 
                          d1.entity_id AS t1_id,
                          d1.first_name AS t1_first_name,
                          d1.last_name AS t1_last_name,
                          d1.full_name AS t1_full_name,
                          d1.alias AS t1_alias,
                          d1.url AS t1_url,
                          d2.abbreviation AS t2_abbr, 
                          d2.entity_id AS t2_id,
                          d2.first_name AS t2_first_name,
                          d2.last_name AS t2_last_name,
                          d2.full_name AS t2_full_name,
                          d2.alias AS t2_alias,
                          d2.url AS t2_url,
                          t1.alignment AS t1_alignment,
                          t1.score AS t1_score,
			                    t1.event_outcome AS t1_outcome,
                          t2.alignment AS t2_alignment,
                          t2.score AS t2_score, 
 			                    t2.event_outcome AS t2_outcome,
 			                    events.id AS event_id,
 			                    events.event_status,
 			                    events.broadcast_listing,
                          CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
               :joins => "INNER JOIN events ON events.id = affiliations_events.event_id
			 INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
			 INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                         INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams'
                         INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "events.start_date_time >= '#{start_date}'",                                    
              :order => "events.start_date_time ASC",
              :limit => n)

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end  

    return games

  end
  
  
  ##############################################################################
  # Description:
  #   Get a team's games and individual game information for a specific date range 
  #   including game date, time, location (home/away), opponent id, and opponent score of a single team.
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to get the scheule as specified by the 
  #             affiliation_id as defined by the id attribute of the 'affiliations' table
  #   -range_end - Time - time from which to get the previous games
  #                   Note: This is an optional parameter that defualts to TIME env variable
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
  def self.get_previous_n_games(affiliation_id, limit = 20, range_end = TIME)
  
    end_date = time_to_datetime(range_end)
  
    games = AffiliationsEvent.find_all_by_affiliation_id(
              affiliation_id, 
              :select => "d1.abbreviation AS t1_abbr, 
                          d1.entity_id AS t1_id,
                          d1.first_name AS t1_first_name,
                          d1.last_name AS t1_last_name,
                          d1.full_name AS t1_full_name,
                          d1.alias AS t1_alias,
                          d1.url AS t1_url,
                          d2.abbreviation AS t2_abbr, 
                          d2.entity_id AS t2_id,
                          d2.first_name AS t2_first_name,
                          d2.last_name AS t2_last_name,
                          d2.full_name AS t2_full_name,
                          d2.alias AS t2_alias,
                          d2.url AS t2_url,
                          t1.alignment AS t1_alignment,
                          t1.score AS t1_score,
			                    t1.event_outcome AS t1_outcome,
                          t2.alignment AS t2_alignment,
                          t2.score AS t2_score, 
 			                    t2.event_outcome AS t2_outcome,
 			                    events.id AS event_id,
 			                    events.event_status,
 			                    events.broadcast_listing,
                          CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
               :joins => "INNER JOIN events ON events.id = affiliations_events.event_id
                          INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
                          INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                          INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams'
                          INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "events.start_date_time <= '#{end_date}'",                                    
              :order => "events.start_date_time DESC",
              :limit => limit)

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end  

    return games

  end
  
  
  #############################################################################
  # Description:
  #   Get the straight spread lines for a given event and team
  #
  # Params:
  #   -affiliation_id - int - the id of the affiliation to get the lines for
  #   -n - int - the number of games you'd like to get the lines for
  #   -range_start - Time - the start date of the range
  #                   Note: This is an optional parameter that defualts to TIME env variable
  #   -bookmaker_id - id of the bookmaker. 
  #            Note: This is an optional parameter that defaults to BOOKMAKER_ID env variable
  #
  # Return:
  #   :select => "wagering_straight_spread_lines.*, display_names.*,  
  #               wagering_straight_spread_lines.line_value AS line",
  #############################################################################
  def self.get_lines(affiliation_id, n = 20, range_start = TIME, bookmaker_id = BOOKMAKER_ID)
  
  
    start_date = time_to_datetime(range_start)

    ActiveRecord::Base.connection.execute("SET sql_big_selects=1")    
  
    games = AffiliationsEvent.find_all_by_affiliation_id(
              affiliation_id, 
              :select => "MAX(t1_score_lines.date_time),
                          d1.abbreviation AS t1_abbr, d1.entity_id AS t1_id, d1.first_name AS t1_first_name, d1.last_name AS t1_last_name, d1.full_name AS t1_full_name, d1.alias AS t1_alias, d1.url AS t1_url,
                          d2.abbreviation AS t2_abbr, d2.entity_id AS t2_id, d2.first_name AS t2_first_name, d2.last_name AS t2_last_name, d2.full_name AS t2_full_name, d2.alias AS t2_alias, d2.url AS t2_url,
                          t1.alignment AS t1_alignment, t1.score AS t1_score,  t1.event_outcome AS t1_outcome,
                          t2.alignment AS t2_alignment, t2.score AS t2_score, 
                          t2.event_outcome AS t2_outcome,
                          t1_spread_lines.line_value AS t1_spread_line,
                          t2_spread_lines.line_value AS t2_spread_line,
                          t1_money_lines.line AS t1_money_line,
                          t2_money_lines.line AS t2_money_line,
                          t1_score_lines.prediction AS t1_prediction,
                          t2_score_lines.prediction AS t2_prediction,
                          t1_score_lines.total AS t1_line_total,
                          t2_score_lines.total AS t2_line_total,
                          t1_score_lines.line_over AS t1_line_over,
                          t2_score_lines.line_over AS t2_line_over,
                          t1_score_lines.line_under AS t1_line_under,
                          t2_score_lines.line_under AS t2_line_under,
                          events.id AS event_id, events.event_status,  events.broadcast_listing, CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') AS start_date_time",
             :joins => "INNER JOIN events ON events.id = affiliations_events.event_id
                        INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
                        INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                        LEFT JOIN wagering_total_score_lines AS t1_score_lines ON t1_score_lines.event_id = events.id AND t1_score_lines.team_id = t1.participant_id AND t1_score_lines.bookmaker_id = #{bookmaker_id}  LEFT JOIN wagering_total_score_lines AS t2_score_lines ON t2_score_lines.event_id = events.id AND t2_score_lines.team_id = t2.participant_id AND t2_score_lines.bookmaker_id = #{bookmaker_id}
                        LEFT JOIN wagering_straight_spread_lines AS t1_spread_lines ON t1_spread_lines.event_id = events.id AND t1_spread_lines.team_id = t1.participant_id AND t1_spread_lines.bookmaker_id = #{bookmaker_id}  LEFT JOIN wagering_straight_spread_lines AS t2_spread_lines ON t2_spread_lines.event_id = events.id AND t2_spread_lines.team_id = t2.participant_id AND t2_spread_lines.bookmaker_id = #{bookmaker_id}
                        LEFT JOIN wagering_moneylines AS t1_money_lines ON t1_money_lines.event_id = events.id AND t1_money_lines.team_id = t1.participant_id AND t1_money_lines.bookmaker_id = #{bookmaker_id}  LEFT JOIN wagering_moneylines AS t2_money_lines ON t2_money_lines.event_id = events.id AND t2_money_lines.team_id = t2.participant_id AND t2_money_lines.bookmaker_id = #{bookmaker_id}
                        INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id AND d1.entity_type = 'teams'
                        INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'",
              :conditions => "events.start_date_time >= '#{start_date}'",                                    
              :group => "events.id",
              :order => "start_date_time ASC",
              :limit => n)

    games.size.times do |i|
      games[i].start_date_time = datetime_to_time(games[i].start_date_time)
    end

    
    return games
  
  end
  
  
  #############################################################################
  # Description:
  #   Get the scoring leaders for a given league
  #
  # Parameters:
  #   -affiliation_id - int - id of the affiliation/league to get the leaders for
  #   -repository_type - string - name of the table to retrieve the leader stats for 
  #                               (e.g. "basketball_offensive_stats" or "baseball_pitching_stats")
  #   -order - string - SQL statement for the order to return results in. This should be the 
  #        table's column name for which you want the leaders. If the column is a number you need
  #        to add '+ 0' to the order string. (e.g. "points_scored_per_game + 0 DESC")
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #   -limit - int - number of results to return
  #                 NOTE: This is an optional parameter that defaults to 50
  #
  # Return:
  #   :select => "display_names.*, stat_repository.*, team_phases.team_id, person_phases.person_id"
  #############################################################################
  def self.get_leaders(affiliation_id, order, time = TIME, limit = 50)
  
    season_key = get_season_key(affiliation_id, time)
    time = time_to_datetime(time)
    
    
    return Affiliation.find_all_by_affiliation_type(
                          "league",
                          :select => "display_names.*, basketball_offensive_stats.*, team_phases.team_id, person_phases.person_id",
                          :joins => "
                            INNER JOIN teams 
                            INNER JOIN team_phases ON team_phases.team_id = teams.id AND team_phases.affiliation_id = #{affiliation_id}
                            INNER JOIN person_phases ON person_phases.membership_id = teams.id
                            INNER JOIN seasons ON seasons.league_id = #{affiliation_id} AND seasons.season_key = #{season_key}
                            INNER JOIN stats AS off_stats ON off_stats.stat_holder_type = 'persons' AND off_stats.stat_holder_id = person_phases.person_id AND off_stats.stat_coverage_id = seasons.id AND off_stats.stat_repository_type = 'basketball_offensive_stats'
                            INNER JOIN basketball_offensive_stats ON basketball_offensive_stats.id = off_stats.stat_repository_id
                            INNER JOIN display_names ON display_names.entity_id = person_phases.person_id AND display_names.entity_type = 'persons'",
                          :conditions => "affiliations.id = #{affiliation_id} AND affiliations.publisher_id = #{PUBLISHER_ID}",
                          :order => "basketball_offensive_stats." + order,
                          :limit => limit)
  
  end
  
  
  
  
 
  
  #############################################################################
  # Description:
  #   Get the standings for an affiliation
  #
  # Params:
  #   -affiliation_id - int - id of the league to which the sub_affiliation belongs to
  #   -sub_affiliation_id - int - id of the sub affiliation (conference/division id)
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #
  # Return:
  #   :select => "affiliations.id as affiliation_id,
  #               standing_subgroup_affiliations.id as division_id,
  #               teams.id AS team_id,      
  #               outcome_totals.*,
  #               display_names.*",
  #############################################################################
  def self.get_standings(affiliation_id, sub_affiliation_id, 
                         time = TIME, publisher_id = PUBLISHER_ID)

    ret = nil

    league = Affiliation.get_league(affiliation_id)
    
    if (league.affiliation_key =~ /ncaa/) then
      ret = College.get_rankings(affiliation_id, time, publisher_id)
    else
      ret = Professional.get_standings(affiliation_id, sub_affiliation_id, time, publisher_id)
    end

    return ret
  
  end
  
  
  
  
  
  #############################################################################
  # Description:
  #   Get season info (start and end dates) for a particular affiliation and year
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to get the scheule as specified by the 
  #             affiliation_id as defined by the id attribute of the 'affiliations' table
  #   -date - int - date of the season start dates. 
  #                 Note: This is an optional parameter. It can be used to retreive 
  #                       achrival data, and defaults to the current year
  #############################################################################
  def self.get_season(affiliation_id, date = nil)
    
    if (date == nil)
      date = TIME
    end
    
    return Season.find_by_league_id(
              affiliation_id,
              :conditions => "seasons.start_date_time <= '#{date}' AND seasons.end_date_time >= '#{date}'" )
  
  end
  
  #############################################################################
  # Desccription:
  #   Determine is a particular affiliation is currently in season or not
  #
  # Params:
  #   -affiliation_id - int - affiliation for which to determine if it is in season
  #
  # Return:
  #   -boolean - true if the affiliation is in season, false if not
  #   -date - string - date to use in place of currrent date. Must be in format mm/dd/yy
  #                 Note: This is an optional parameter. It can be used to retrieve 
  #                       achrival data, and defaults to the current year
  #############################################################################
  def self.is_in_season(affiliation_id, date = nil)
    result = false
    if (date.blank?)
      time = time_to_datetime(TIME)
    else
      t = Time.parse(date)
      time = time_to_datetime(t)
    end 
    

    season = Season.find_by_league_id(
              affiliation_id,
	            :conditions => "seasons.start_date_time <= '#{time}' AND seasons.end_date_time >= '#{time}'" )

    
    if !(season.blank?)
      result = true
    end
   
    return result
              
  end
 
  #############################################################################
  # Description:
  #  Determine if a league is in a user's profile or not.
  #
  # Params:
  #  -league_id - int - id of the league
  #  -user_id - int - id of the user
  #
  # Return:
  #  True is the league is in the user's profile, false if not
  #############################################################################
  def self.league_is_in_profile(league_id, user_id)
    path = RAILS_ROOT + "/public/users/" + user_id.to_s + "/" + user_id.to_s + ".profile"
    parser = XML::Parser.file(path)
    profile = parser.parse
    
    pro_sports = profile.find('//root/sports/sport')
    pro_sports = pro_sports.to_a
    college_sports = profile.find('//root/sports/collegeSports/sport')
    college_sports = college_sports.to_a
    
    sports = pro_sports.concat(college_sports)

    sports.each do |sport|
      if(sport['id'].to_i == league_id.to_i)
      	return true
      end
    end
     
    return false
  end
  
###############################################################################
# Private function declarations
###############################################################################
protected





  
  
  
end
