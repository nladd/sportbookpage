class BasketballOffensiveStat < ActiveRecord::Base
  validates_numericality_of :field_goals_made, :allow_nil => true, :only_integer => true
  validates_numericality_of :field_goals_attempted, :allow_nil => true, :only_integer => true
  validates_length_of :field_goals_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_attempted_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :field_goals_percentage_adjusted, :allow_nil => true, :maximum => 100
  validates_numericality_of :three_pointers_made, :allow_nil => true, :only_integer => true
  validates_numericality_of :three_pointers_attempted, :allow_nil => true, :only_integer => true
  validates_length_of :three_pointers_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :three_pointers_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :three_pointers_attempted_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :free_throws_made, :allow_nil => true, :maximum => 100
  validates_length_of :free_throws_attempted, :allow_nil => true, :maximum => 100
  validates_length_of :free_throws_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :free_throws_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :free_throws_attempted_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_total, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :assists_total, :allow_nil => true, :maximum => 100
  validates_length_of :assists_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :turnovers_total, :allow_nil => true, :maximum => 100
  validates_length_of :turnovers_per_game, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_off_turnovers, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_in_paint, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_on_second_chance, :allow_nil => true, :maximum => 100
  validates_length_of :points_scored_on_fast_break, :allow_nil => true, :maximum => 100
end
