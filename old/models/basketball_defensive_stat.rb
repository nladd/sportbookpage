class BasketballDefensiveStat < ActiveRecord::Base
  validates_length_of :steals_total, :allow_nil => true, :maximum => 100
  validates_length_of :steals_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :blocks_total, :allow_nil => true, :maximum => 100
  validates_length_of :blocks_per_game, :allow_nil => true, :maximum => 100
end
