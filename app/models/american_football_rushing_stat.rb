class AmericanFootballRushingStat < ActiveRecord::Base
  validates_length_of :rushes_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :rushes_yards, :allow_nil => true, :maximum => 100
  validates_length_of :rushes_touchdowns, :allow_nil => true, :maximum => 100
  validates_length_of :rushing_average_yards_per, :allow_nil => true, :maximum => 100
  validates_length_of :rushes_first_down, :allow_nil => true, :maximum => 100
  validates_length_of :rushes_longest, :allow_nil => true, :maximum => 100
end
