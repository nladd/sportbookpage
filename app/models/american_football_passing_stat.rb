class AmericanFootballPassingStat < ActiveRecord::Base
  validates_length_of :passes_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :passes_completions, :allow_nil => true, :maximum => 100
  validates_length_of :passes_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :passes_yards_gross, :allow_nil => true, :maximum => 100
  validates_length_of :passes_yards_net, :allow_nil => true, :maximum => 100
  validates_length_of :passes_yards_lost, :allow_nil => true, :maximum => 100
  validates_length_of :passes_touchdowns, :allow_nil => true, :maximum => 100
  validates_length_of :passes_touchdowns_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :passes_interceptions, :allow_nil => true, :maximum => 100
  validates_length_of :passes_interceptions_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :passes_longest, :allow_nil => true, :maximum => 100
  validates_length_of :passes_average_yards_per, :allow_nil => true, :maximum => 100
  validates_length_of :passer_rating, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_total, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_yards, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_touchdowns, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_first_down, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_longest, :allow_nil => true, :maximum => 100
  validates_length_of :receptions_average_yards_per, :allow_nil => true, :maximum => 100
end
