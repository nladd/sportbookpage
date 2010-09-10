class AmericanFootballPenaltiesStat < ActiveRecord::Base
  validates_length_of :penalties_total, :allow_nil => true, :maximum => 100
  validates_length_of :penalty_yards, :allow_nil => true, :maximum => 100
  validates_length_of :penalty_first_downs, :allow_nil => true, :maximum => 100
end
