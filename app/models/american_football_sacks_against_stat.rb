class AmericanFootballSacksAgainstStat < ActiveRecord::Base
  validates_length_of :sacks_against_yards, :allow_nil => true, :maximum => 100
  validates_length_of :sacks_against_total, :allow_nil => true, :maximum => 100
end
