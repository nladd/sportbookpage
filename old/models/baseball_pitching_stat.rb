class BaseballPitchingStat < ActiveRecord::Base
  validates_numericality_of :runs_allowed, :allow_nil => true, :only_integer => true
  validates_numericality_of :singles_allowed, :allow_nil => true, :only_integer => true
  validates_numericality_of :doubles_allowed, :allow_nil => true, :only_integer => true
  validates_numericality_of :triples_allowed, :allow_nil => true, :only_integer => true
  validates_numericality_of :home_runs_allowed, :allow_nil => true, :only_integer => true
  validates_length_of :innings_pitched, :allow_nil => true, :maximum => 20
  validates_numericality_of :hits, :allow_nil => true, :only_integer => true
  validates_numericality_of :earned_runs, :allow_nil => true, :only_integer => true
  validates_numericality_of :unearned_runs, :allow_nil => true, :only_integer => true
  validates_numericality_of :bases_on_balls, :allow_nil => true, :only_integer => true
  validates_numericality_of :bases_on_balls_intentional, :allow_nil => true, :only_integer => true
  validates_numericality_of :strikeouts, :allow_nil => true, :only_integer => true
  validates_numericality_of :strikeout_to_bb_ratio, :allow_nil => true
  validates_numericality_of :number_of_pitches, :allow_nil => true, :only_integer => true
  validates_numericality_of :era, :allow_nil => true
  validates_numericality_of :inherited_runners_scored, :allow_nil => true, :only_integer => true
  validates_numericality_of :pick_offs, :allow_nil => true, :only_integer => true
  validates_numericality_of :errors_hit_with_pitch, :allow_nil => true, :only_integer => true
  validates_numericality_of :errors_wild_pitch, :allow_nil => true, :only_integer => true
  validates_numericality_of :balks, :allow_nil => true, :only_integer => true
  validates_numericality_of :wins, :allow_nil => true, :only_integer => true
  validates_numericality_of :losses, :allow_nil => true, :only_integer => true
  validates_numericality_of :saves, :allow_nil => true, :only_integer => true
  validates_numericality_of :shutouts, :allow_nil => true, :only_integer => true
  validates_numericality_of :games_complete, :allow_nil => true, :only_integer => true
  validates_numericality_of :games_finished, :allow_nil => true, :only_integer => true
  validates_numericality_of :winning_percentage, :allow_nil => true
  validates_length_of :event_credit, :allow_nil => true, :maximum => 40
  validates_length_of :save_credit, :allow_nil => true, :maximum => 40
end
