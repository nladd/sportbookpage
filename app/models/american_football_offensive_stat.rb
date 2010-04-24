class AmericanFootballOffensiveStat < ActiveRecord::Base
  validates_length_of :offensive_plays_yards, :allow_nil => true, :maximum => 100
  validates_length_of :offensive_plays_number, :allow_nil => true, :maximum => 100
  validates_length_of :offensive_plays_average_yards_per, :allow_nil => true, :maximum => 100
  validates_length_of :possession_duration, :allow_nil => true, :maximum => 100
  validates_length_of :turnovers_giveaway, :allow_nil => true, :maximum => 100
end
