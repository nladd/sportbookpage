class BasketballReboundingStat < ActiveRecord::Base
  validates_length_of :rebounds_total, :allow_nil => true, :maximum => 100
  validates_length_of :rebounds_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :rebounds_defensive, :allow_nil => true, :maximum => 100
  validates_length_of :rebounds_offensive, :allow_nil => true, :maximum => 100
  validates_length_of :team_rebounds_total, :allow_nil => true, :maximum => 100
  validates_length_of :team_rebounds_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :team_rebounds_defensive, :allow_nil => true, :maximum => 100
  validates_length_of :team_rebounds_offensive, :allow_nil => true, :maximum => 100
end
