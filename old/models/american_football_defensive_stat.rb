class AmericanFootballDefensiveStat < ActiveRecord::Base
  validates_length_of :tackles_total, :allow_nil => true, :maximum => 100
  validates_length_of :tackles_solo, :allow_nil => true, :maximum => 100
  validates_length_of :tackles_assists, :allow_nil => true, :maximum => 100
  validates_length_of :interceptions_total, :allow_nil => true, :maximum => 100
  validates_length_of :interceptions_yards, :allow_nil => true, :maximum => 100
  validates_length_of :interceptions_average, :allow_nil => true, :maximum => 100
  validates_length_of :interceptions_longest, :allow_nil => true, :maximum => 100
  validates_length_of :interceptions_touchdown, :allow_nil => true, :maximum => 100
  validates_length_of :quarterback_hurries, :allow_nil => true, :maximum => 100
  validates_length_of :sacks_total, :allow_nil => true, :maximum => 100
  validates_length_of :sacks_yards, :allow_nil => true, :maximum => 100
  validates_length_of :passes_defensed, :allow_nil => true, :maximum => 100
end
