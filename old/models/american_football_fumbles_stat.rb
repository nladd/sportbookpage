class AmericanFootballFumblesStat < ActiveRecord::Base
  validates_length_of :fumbles_committed, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_forced, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_recovered, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_lost, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_yards_gained, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_own_committed, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_own_recovered, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_own_lost, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_own_yards_gained, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_opposing_committed, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_opposing_recovered, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_opposing_lost, :allow_nil => true, :maximum => 100
  validates_length_of :fumbles_opposing_yards_gained, :allow_nil => true, :maximum => 100
end
