class AmericanFootballTeamStats < ActiveRecord::Base

  validates_length_of :yards_per_game, :maximum => 100
  validates_length_of :average_starting_position, :maximum => 100
  validates_length_of :timeouts, :maximum => 100
  validates_length_of :time_of_possession, :maximum => 100
  validates_length_of :turnover_ratio, :maximum => 100

end
