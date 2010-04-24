class Event < ActiveRecord::Base
  
  has_many :participants_events, :class_name => "ParticipantsEvent", :foreign_key => "event_id"
  
  validates_presence_of :event_key
  validates_length_of :event_key, :allow_nil => false, :maximum => 100
  validates_length_of :site_alignment, :allow_nil => true, :maximum => 100
  validates_length_of :event_status, :allow_nil => true, :maximum => 100
  validates_length_of :duration, :allow_nil => true, :maximum => 100
  validates_length_of :attendance, :allow_nil => true, :maximum => 100
  
  
   ############################################################################
  # Description:
  #       -Returns each team's score for a game
  #
  # Parameters:
  #       -event_id - the id of the event to get the scores for
  #
  # Return:
  #       -ParticipantEvent[] - An array of 2 ParticipantEvents. Home team is index 0,
  #             away team is index 1
   ############################################################################
  def self.get_scores(event_id)
    return ParticipantsEvent.find_all_by_event_id(
                event_id, 
                :select => "display_names.*_name, display_names.abbreviation, participants_events.alignment, participants_events.score, participants_events.event_outcome, participants_events.rank",
                :joins => "INNER JOIN display_names ON display_names.entity_id = participants_events.participant_id AND display_names.entity_type = 'teams'",
                :order => "alignment DESC")
  end
  
  #############################################################################
  # Description:
  #   Get all games between the specified home team and away team for a given season
  #
  # Params:
  #   -home_team_id - int - the id of the home team
  #   -away_team_id - int - the id of the away team
  #   -year - int - the year of the season to get the games. The year should be that which 
  #                 the desired season starts in. E.g. the 09-10 season should be specified 
  #                 with a year of 2009.
  #                 Note: This is an optional parameter and defaults to the current year
  #
  # Return:
  #   :select => "events.start_date_time, events.id",
  #############################################################################
  def self.get_game_dates(home_team_id, away_team_id, year = nil)
  
    if (year == nil)
      year = TIME.year
    end
    
    cur_date = time_to_datetime(TIME)
    
    affiliation_id = TeamPhase.find_by_team_id(
      home_team_id, 
      :select => "affiliation_id",
      :joins => "INNER JOIN affiliations ON affiliations.id = team_phases.affiliation_id AND affiliations.affiliation_type = 'league'").affiliation_id
    season_id = Affiliation.get_season(affiliation_id, year).id
    
    
    return ParticipantsEvent.find(
                  :all, 
                  :select => "CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, events.id",
                  :from => "participants_events AS t1",
                  :joins => "INNER JOIN participants_events AS t2 ON (t2.participant_id = #{away_team_id} AND t2.event_id = t1.event_id)
                             INNER JOIN events ON events.id = t1.event_id AND events.id = t2.event_id
			     INNER JOIN sub_seasons ON sub_seasons.season_id = #{season_id}
                             INNER JOIN events_sub_seasons ON events_sub_seasons.event_id = t1.event_id AND events_sub_seasons.sub_season_id = sub_seasons.id",
                  :conditions => "t1.participant_id = #{home_team_id} AND t1.alignment = 'home' AND t1.participant_type = 'teams' AND events.start_date_time > '#{cur_date}' ",
                  :order => "events.start_date_time ASC")
  
  end
 
  
  #############################################################################
  # Description:
  #   Get an event details (i.e. teams, start time ...) given an event id
  #
  # Params:
  #   -event_id - int - id of the event
  #
  # Return:
  #   :select => "events.id AS event_id, events.start_date_time AS start_date_time,
  #               d1.full_name AS home_full_name, d1.first_name AS home_first_name, d1.last_name AS home_last_name, d1.url AS home_url, d1.entity_id AS home_id,
  #               d2.full_name AS away_full_name, d2.first_name AS away_first_name, d2.last_name AS away_last_name, d2.url AS away_url, d2.entity_id AS away_id,
  #               t1.alignment AS home_alignment, t1.score AS home_score, t1.event_outcome AS home_event_outcome,
  #               t2.alignment AS away_alignment, t2.score AS away_score, t2.event_outcome AS away_event_outcome"
  #############################################################################
  def self.get_event(event_id)

    return Event.find_by_id(event_id,
		:select => "events.id AS event_id, CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, 
                            d1.full_name AS home_full_name, d1.first_name AS home_first_name, d1.last_name AS home_last_name, d1.url AS home_url, d1.entity_id AS home_id, 
                            d2.full_name AS away_full_name, d2.first_name AS away_first_name, d2.last_name AS away_last_name, d2.url AS away_url, d2.entity_id AS away_id, 
                            t1.alignment AS home_alignment, t1.score AS home_score, t1.event_outcome AS home_event_outcome, 
                            t2.alignment AS away_alignment, t2.score AS away_score, t2.event_outcome AS away_event_outcome",
                :joins => "INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.alignment = 'home'
                           INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.alignment = 'away'
                           INNER JOIN display_names AS d1 ON d1.entity_id = t1.participant_id and d1.entity_type = 'teams'
                           INNER JOIN display_names AS d2 ON d2.entity_id = t2.participant_id AND d2.entity_type = 'teams'")

  end 
  
  
  #############################################################################
  # Description
  #   Get an event state by event id
  #
  # Params:
  #   -event_id - int - id of the event
  #   -sport - int - sport event belongs to. Used to determine which table to pull 
  #                  the data from
  #
  # Return:
  #     :select => "event_states.*"
  #############################################################################
  def self.get_event_state(event_id, sport)
  
    sport = sport.downcase
    ret = ""
    if (sport == 'baseball')
      state = Event.find(
                    event_id,
                    :select => "event_states.*",
                    :joins => "INNER JOIN baseball_event_states AS event_states ON event_states.event_id = events.id AND event_states.context = 'event-play'")
      
      ret = "I" + state.inning_value.to_s + " " + state.inning_half.to_s + " " + state.strikes.to_s + "-" + state.balls.to_s + "-" + state.outs.to_s
      
    elsif (sport == 'basketball')
      state = Event.find(
                    event_id,
                    :select => "event_states.*",
                    :joins => "INNER JOIN basketball_event_states AS event_states ON event_states.event_id = events.id AND event_states.context = 'event-play'")
      
      ret = "Q" + state.period_value.to_s + " " + state.period_time_remaining.to_s
    elsif (sport == 'ice hockey')
      state = Event.find(
                    event_id,
                    :select => "event_states.*",
                    :joins => "INNER JOIN ice_hockey_event_states AS event_states ON event_states.event_id = events.id AND event_states.context = 'event-play'")
      
      ret = "P" + state.period_value.to_s + " " + state.period_time_remaining.to_s
    elsif (sport == 'american football')
      state = Event.find(
                    event_id,
                    :select => "event_states.*",
                    :joins => "INNER JOIN american_football_event_states AS event_states ON event_states.event_id = events.id AND event_states.context = 'event-play'")
      
      ret = "Q" + state.period_value.to_s + " " + state.period_time_remaining.to_s
      
      
    else
      return
    end
    
  
    return ret
    
  
  end

 
end
