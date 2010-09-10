class TeamAmericanFootballStat < ActiveRecord::Base
  validates_length_of :yards_per_attempt, :allow_nil => true, :maximum => 100
  validates_length_of :average_starting_position, :allow_nil => true, :maximum => 100
  validates_length_of :timeouts, :allow_nil => true, :maximum => 100
  validates_length_of :time_of_possession, :allow_nil => true, :maximum => 100
  validates_length_of :turnover_ratio, :allow_nil => true, :maximum => 100
end
