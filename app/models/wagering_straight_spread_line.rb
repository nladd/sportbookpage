
require 'model_helpers.rb'

class WageringStraightSpreadLine < ActiveRecord::Base
  validates_length_of :rotation_key, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
  validates_length_of :vigorish, :allow_nil => true, :maximum => 100
  validates_length_of :line_value, :allow_nil => true, :maximum => 100
  validates_length_of :line_value_opening, :allow_nil => true, :maximum => 100
  validates_length_of :prediction, :allow_nil => true, :maximum => 100
  
  
  

  #############################################################################
  # Description:
  #   Get the straight spread lines for the favorite for a given event
  #
  # Params:
  #   -event_id - int - id of the event
  #   -bookmaker_id - id of the bookmaker. 
  #   -bookmaker_id - id of the bookmaker. 
  #            Note: This is an optional parameter that defaults to BOOKMAKER_ID env variable
  #
  # Return:
  #   :select => "wagering_straight_spread_lines.*, display_names.*, 
  #               wagering_straight_spread_lines.line_value AS line",
  #############################################################################
  def self.get_event_favorite(event_id, bookmaker_id = BOOKMAKER_ID)
  
    
    return WageringStraightSpreadLine.find_by_event_id(
                    event_id,
                    :select => "wagering_straight_spread_lines.*, display_names.*, 
                                wagering_straight_spread_lines.line_value AS line",
                    :joins => "INNER JOIN display_names ON entity_id = wagering_straight_spread_lines.team_id AND entity_type = 'teams'",
                    :conditions => "wagering_straight_spread_lines.prediction = 'favorite'")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get the straight spread lines for the underdog for a given event
  #
  # Params:
  #   -event_id - int - id of the event
  #   -bookmaker_id - id of the bookmaker.
  #            Note: This is an optional parameter that defaults to BOOKMAKER_ID env variable
  #
  # Return:
  #  :select => "wagering_straight_spread_lines.*, display_names.*, 
  #              wagering_straight_spread_lines.line_value AS line",
  #############################################################################
  def self.get_event_underdog(event_id, bookmaker_id = BOOKMAKER_ID)

    return WageringStraightSpreadLine.find_by_event_id(
                    event_id,
                    :select => "wagering_straight_spread_lines.*, display_names.*, 
                                wagering_straight_spread_lines.line_value AS line",
                    :joins => "INNER JOIN display_names ON entity_id = wagering_straight_spread_lines.team_id AND entity_type = 'teams'",
                    :conditions => "wagering_straight_spread_lines.prediction = 'underdog'")
  
  end
  
  
  
  
end
