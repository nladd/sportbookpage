class Challenges < ActiveRecord::Base

  validates_presence_of :challengee_id, :challenger_id, :event_id, :wager, :spread, :favorite_id, :league_id, :underdog_id

  
  #############################################################################
  # Description:
  #   Get a single challenge
  #
  # Params:
  #   -challenge_id - int - id of the challenge
  #
  # Return:
  #  :select => "challenges.*, events.start_date_time,
  #              league.full_name AS league_full_name, league.abbreviation AS league_abbreviation,
  #              favorite.first_name AS favorite_first_name, favorite.last_name AS favorite_last_name, favorite.full_name AS favorite_full_name, favorite.abbreviation AS favorite_abbreviation,
  #              underdog.first_name AS underdog_first_name, underdog.last_name AS underdog_last_name, underdog.full_name AS underdog_full_name, underdog.abbreviation AS underdog_abbreviation"
  #############################################################################
  def self.get_challenge(challenge_id)

    return Challenges.find(
                        challenge_id,
                        :select => "challenges.*, CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time,
                                    league.full_name AS league_full_name, league.abbreviation AS league_abbreviation,
                                    favorite.entity_id AS favorite_id, favorite.first_name AS favorite_first_name, favorite.last_name AS favorite_last_name, favorite.full_name AS favorite_full_name, favorite.abbreviation AS favorite_abbreviation,
                                    underdog.entity_id AS underdog_id, underdog.first_name AS underdog_first_name, underdog.last_name AS underdog_last_name, underdog.full_name AS underdog_full_name, underdog.abbreviation AS underdog_abbreviation",
                        :joins => "INNER JOIN display_names AS league ON league.entity_id = challenges.league_id AND league.entity_type = 'affiliations'
                                   INNER JOIN display_names AS favorite ON favorite.entity_id = challenges.favorite_id AND favorite.entity_type = 'teams'
                                   INNER JOIN display_names AS underdog ON underdog.entity_id = challenges.underdog_id AND underdog.entity_type = 'teams'
                                   INNER JOIN events ON events.id = challenges.event_id")

  end


  #############################################################################
  # Description:
  #   Get all challenges for a given user
  #
  # Params:
  #   -user_id - int - id of the user
  #   -order - string - SQL syntax string to specify the order of returned results
  #                     Note: This is an optional parameter that default to
  #                     "league.abbreviation ASC, challenges.start_date_time ASC"
  #
  # Return:
  #  :select => "challenges.*, events.start_date_time,
  #              league.full_name AS league_full_name, league.abbreviation AS league_abbreviation,
  #              favorite.first_name AS favorite_first_name, favorite.last_name AS favorite_last_name, favorite.full_name AS favorite_full_name, favorite.abbreviation AS favorite_abbreviation,
  #              underdog.first_name AS underdog_first_name, underdog.last_name AS underdog_last_name, underdog.full_name AS underdog_full_name, underdog.abbreviation AS underdog_abbreviation"
  #############################################################################
  def self.get_challenges(user_id, order = nil)

    if(order.blank?)
      order = "league.abbreviation ASC, challenges.start_date_time ASC"
    end

    return Challenges.find(
                        :all,
                        :select => "challenges.*, CONVERT_TZ(challenges.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, 
                                    league.full_name AS league_full_name, league.abbreviation AS league_abbreviation,
                                    favorite.first_name AS favorite_first_name, favorite.last_name AS favorite_last_name, favorite.full_name AS favorite_full_name, favorite.abbreviation AS favorite_abbreviation,
                                    underdog.first_name AS underdog_first_name, underdog.last_name AS underdog_last_name, underdog.full_name AS underdog_full_name, underdog.abbreviation AS underdog_abbreviation",
                        :joins => "INNER JOIN display_names AS league ON league.entity_id = challenges.league_id AND league.entity_type = 'affiliations'
                                   INNER JOIN display_names AS favorite ON favorite.entity_id = challenges.favorite_id AND favorite.entity_type = 'teams'
                                   INNER JOIN display_names AS underdog ON underdog.entity_id = challenges.underdog_id AND underdog.entity_type = 'teams'
                                   INNER JOIN events ON events.id = challenges.event_id",
                        :conditions => "challenger_id = #{user_id} OR challengee_id = #{user_id}",
                        :order => order)

  end

  
  #############################################################################
  # Description:
  #   Get all challenges that have been issued by a user (ergo the user is the 
  #   challenger)
  #
  # Params:
  #   -user_id - int - id of the user that issued the challenge
  #   -order - string - SQL syntax string to specify the order of returned results
  #                     Note: This is an optional parameter that default to 
  #                     "display_names.abbreviation ASC, challenges.start_date_time ASC"
  #
  #############################################################################
  def self.get_issued_challenges(user_id, order = nil)

    if(order.blank?)
      order = "display_names.abbreviation ASC, challenges.start_date_time ASC"
    end

    return Challenges.find_all_by_challenger_id(
			user_id,
			:select => "challenges.*, CONVERT_TZ(challenges.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, display_names.*",
                        :joins => "INNER JOIN display_names ON display_names.entity_id = challenges.league_id AND display_names.entity_type = 'affiliations'",
                        :conditions => "challenges.accepted = 'yes'",
                        :order => order)


  end


  #############################################################################
  # Description:
  #   Get all challenges that have been accepted by a user (ergo the user is the
  #   challengee)
  #
  # Params:
  #   -user_id - int - id of the user that accepted the challenge
  #   -order - string - SQL syntax string to specify the order of returned results
  #                     Note: This is an optional parameter that default to
  #                     "display_names.abbreviation ASC AND challenges.start_date_time ASC"
  #
  #############################################################################
  def self.get_accepted_challenges(user_id, order = nil)

    if(order.blank?)
      order = "display_names.abbreviation ASC, challenges.start_date_time ASC"
    end

    return Challenges.find_all_by_challengee_id(
                        user_id,
                        :select => "challenges.*, display_names.*",
                        :joins => "INNER JOIN display_names ON display_names.entity_id = challenges.league_id AND display_names.entity_type = 'affiliations'",
                        :conditions => "challenges.accepted = 'yes'",
                        :order => order)


  end


  #############################################################################
  # Description:
  #   Get all challenges that are pending for a user (ergo haven't been accpeted yet)
  #
  # Params:
  #   -user_id - int - id of the user that has pending challenges
  #   -order - string - SQL syntax string to specify the order of returned results
  #                     Note: This is an optional parameter that default to
  #                     "display_names.abbreviation ASC AND challenges.start_date_time ASC"
  #
  #############################################################################
  def self.get_pending_challenges(user_id, order = nil)

    if(order.blank?)
      order = "display_names.abbreviation ASC, challenges.start_date_time ASC"
    end

    return Challenges.find(
                        :all,
                        :select => "challenges.*, CONVERT_TZ(challenges.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time, display_names.*",
                        :joins => "INNER JOIN display_names ON display_names.entity_id = challenges.league_id AND display_names.entity_type = 'affiliations'",
                        :conditions => "challenges.accepted = 'no' AND (challenges.challengee_id = #{user_id} OR challenges.challenger_id = #{user_id})",
                        :order => order)

  end

end
