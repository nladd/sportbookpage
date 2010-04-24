class OutcomeTotal < ActiveRecord::Base
  
  belongs_to :standing_subgroups, :class_name => "StandingSubgroup", :foreign_key => "standing_subgroup_id"

  validates_length_of :outcome_holder_type, :allow_nil => true, :maximum => 100
  validates_length_of :rank, :allow_nil => true, :maximum => 100
  validates_length_of :wins, :allow_nil => true, :maximum => 100
  validates_length_of :losses, :allow_nil => true, :maximum => 100
  validates_length_of :ties, :allow_nil => true, :maximum => 100
  validates_length_of :undecideds, :allow_nil => true, :maximum => 100
  validates_length_of :winning_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_for, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_against, :allow_nil => true, :maximum => 100
  validates_length_of :points_difference, :allow_nil => true, :maximum => 100
  validates_length_of :standing_points, :allow_nil => true, :maximum => 100
  validates_length_of :streak_type, :allow_nil => true, :maximum => 100
  validates_length_of :streak_duration, :allow_nil => true, :maximum => 100
  validates_length_of :streak_total, :allow_nil => true, :maximum => 100
  validates_length_of :events_played, :allow_nil => true, :maximum => 100
  validates_length_of :games_back, :allow_nil => true, :maximum => 100
  validates_length_of :result_effect, :allow_nil => true, :maximum => 100
  validates_length_of :sets_against, :allow_nil => true, :maximum => 100
  validates_length_of :sets_for, :allow_nil => true, :maximum => 100
end
