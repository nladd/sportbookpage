class WageringMoneyline < ActiveRecord::Base
  validates_length_of :rotation_key, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
  validates_length_of :vigorish, :allow_nil => true, :maximum => 100
  validates_length_of :line, :allow_nil => true, :maximum => 100
  validates_length_of :line_opening, :allow_nil => true, :maximum => 100
  validates_length_of :prediction, :allow_nil => true, :maximum => 100
  
  
  #############################################################################
  # Description:
  #   Get the straight spread lines for a given event and team
  #
  # Params:
  #   -event_id - int - id of the event
  #   -team_id - int - id of the team
  #   -bookmaker_id - id of the bookmaker. Note: This is an optional parameter that defaults
  #                   to 6 (or lvsc.com)
  #
  # Return:
  #   :select => "wagering_straight_spread_lines.*, display_names.*"
  #############################################################################
  def self.get_lines(event_id, team_id, bookmaker_id = nil)
  
    if(bookmaker_id.blank?)
      bookmaker_id = 6
    end
    
    return WageringMoneyline.find_by_event_id_and_team_id(
                    event_id,
                    team_id,
                    :select => "*",
                    :joins => "INNER JOIN display_names ON entity_id = #{team_id} AND entity_type = 'teams'")
  
  end

  #############################################################################
  # Description:
  #   Get the straight spread lines for the favorite for a given event
  #
  # Params:
  #   -event_id - int - id of the event
  #   -bookmaker_id - id of the bookmaker. Note: This is an optional parameter that defaults
  #                   to 6 (or lvsc.com)
  #
  # Return:
  #   :select => "wagering_straight_spread_lines.*, display_names.*"
  #############################################################################
  def self.get_event_favorite(event_id, bookmaker_id = nil)
  
    if(bookmaker_id.blank?)
      bookmaker_id = 6
    end
    
    return WageringMoneyline.find_by_event_id(
                    event_id,
                    :select => "*",
                    :joins => "INNER JOIN display_names ON entity_id = wagering_moneylines.team_id AND entity_type = 'teams'",
                    :conditions => "wagering_moneylines.prediction = 'favorite'")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get the straight spread lines for the underdog for a given event
  #
  # Params:
  #   -event_id - int - id of the event
  #   -bookmaker_id - id of the bookmaker. Note: This is an optional parameter that defaults
  #                   to 6 (or lvsc.com)
  #
  # Return:
  #   :select => "wagering_straight_spread_lines.*, display_names.*"
  #############################################################################
  def self.get_event_underdog(event_id, bookmaker_id = nil)
  
    if(bookmaker_id.blank?)
      bookmaker_id = 6
    end
    
    return WageringMoneyline.find_by_event_id(
                    event_id,
                    :select => "*",
                    :joins => "INNER JOIN display_names ON entity_id = wagering_moneylines.team_id AND entity_type = 'teams'",
                    :conditions => "wagering_moneylines.prediction = 'underdog'")
  
  end
  
  
end
