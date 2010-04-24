class IceHockeyDefensiveStat < ActiveRecord::Base
  validates_length_of :shots_power_play_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :shots_penalty_shot_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_power_play_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_penalty_shot_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_against_average, :allow_nil => true, :maximum => 100
  validates_length_of :saves, :allow_nil => true, :maximum => 100
  validates_length_of :save_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :penalty_killing_amount, :allow_nil => true, :maximum => 100
  validates_length_of :penalty_killing_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :shots_blocked, :allow_nil => true, :maximum => 100
  validates_length_of :takeaways, :allow_nil => true, :maximum => 100
  validates_length_of :shutouts, :allow_nil => true, :maximum => 100
  validates_length_of :minutes_penalty_killing, :allow_nil => true, :maximum => 100
  validates_length_of :hits, :allow_nil => true, :maximum => 100
  validates_length_of :goals_empty_net_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_short_handed_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_shootout_allowed, :allow_nil => true, :maximum => 100
  validates_length_of :shots_shootout_allowed, :allow_nil => true, :maximum => 100
end
