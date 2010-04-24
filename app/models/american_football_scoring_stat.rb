class AmericanFootballScoringStat < ActiveRecord::Base
  validates_length_of :touchdowns_total, :allow_nil => true, :maximum => 100
  validates_length_of :touchdowns_passing, :allow_nil => true, :maximum => 100
  validates_length_of :touchdowns_rushing, :allow_nil => true, :maximum => 100
  validates_length_of :touchdowns_special_teams, :allow_nil => true, :maximum => 100
  validates_length_of :touchdowns_defensive, :allow_nil => true, :maximum => 100
  validates_length_of :extra_points_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :extra_points_made, :allow_nil => true, :maximum => 100
  validates_length_of :extra_points_missed, :allow_nil => true, :maximum => 100
  validates_length_of :extra_points_blocked, :allow_nil => true, :maximum => 100
  validates_length_of :field_goal_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_made, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_missed, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_blocked, :allow_nil => true, :maximum => 100
  validates_length_of :safeties_against, :allow_nil => true, :maximum => 100
  validates_length_of :two_point_conversions_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :two_point_conversions_made, :allow_nil => true, :maximum => 100
  validates_length_of :touchbacks_total, :allow_nil => true, :maximum => 100
end
