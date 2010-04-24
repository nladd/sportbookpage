class IceHockeyOffensiveStat < ActiveRecord::Base
  validates_length_of :goals_game_winning, :allow_nil => true, :maximum => 100
  validates_length_of :goals_game_tying, :allow_nil => true, :maximum => 100
  validates_length_of :goals_power_play, :allow_nil => true, :maximum => 100
  validates_length_of :goals_short_handed, :allow_nil => true, :maximum => 100
  validates_length_of :goals_even_strength, :allow_nil => true, :maximum => 100
  validates_length_of :goals_empty_net, :allow_nil => true, :maximum => 100
  validates_length_of :goals_overtime, :allow_nil => true, :maximum => 100
  validates_length_of :goals_shootout, :allow_nil => true, :maximum => 100
  validates_length_of :goals_penalty_shot, :allow_nil => true, :maximum => 100
  validates_length_of :assists, :allow_nil => true, :maximum => 100
  validates_length_of :points, :allow_nil => true, :maximum => 100
  validates_length_of :power_play_amount, :allow_nil => true, :maximum => 100
  validates_length_of :power_play_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :shots_penalty_shot_taken, :allow_nil => true, :maximum => 100
  validates_length_of :shots_penalty_shot_missed, :allow_nil => true, :maximum => 100
  validates_length_of :shots_penalty_shot_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :giveaways, :allow_nil => true, :maximum => 100
  validates_length_of :minutes_power_play, :allow_nil => true, :maximum => 100
  validates_length_of :faceoff_wins, :allow_nil => true, :maximum => 100
  validates_length_of :faceoff_losses, :allow_nil => true, :maximum => 100
  validates_length_of :faceoff_win_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :scoring_chances, :allow_nil => true, :maximum => 100
end
