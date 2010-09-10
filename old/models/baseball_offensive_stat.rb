class BaseballOffensiveStat < ActiveRecord::Base
  validates_numericality_of :average, :allow_nil => true
  validates_numericality_of :runs_scored, :allow_nil => true, :only_integer => true
  validates_numericality_of :at_bats, :allow_nil => true, :only_integer => true
  validates_numericality_of :hits, :allow_nil => true, :only_integer => true
  validates_numericality_of :rbi, :allow_nil => true, :only_integer => true
  validates_numericality_of :total_bases, :allow_nil => true, :only_integer => true
  validates_numericality_of :slugging_percentage, :allow_nil => true
  validates_numericality_of :bases_on_balls, :allow_nil => true, :only_integer => true
  validates_numericality_of :strikeouts, :allow_nil => true, :only_integer => true
  validates_numericality_of :left_on_base, :allow_nil => true, :only_integer => true
  validates_numericality_of :left_in_scoring_position, :allow_nil => true, :only_integer => true
  validates_numericality_of :singles, :allow_nil => true, :only_integer => true
  validates_numericality_of :doubles, :allow_nil => true, :only_integer => true
  validates_numericality_of :triples, :allow_nil => true, :only_integer => true
  validates_numericality_of :home_runs, :allow_nil => true, :only_integer => true
  validates_numericality_of :grand_slams, :allow_nil => true, :only_integer => true
  validates_numericality_of :at_bats_per_rbi, :allow_nil => true
  validates_numericality_of :plate_appearances_per_rbi, :allow_nil => true
  validates_numericality_of :at_bats_per_home_run, :allow_nil => true
  validates_numericality_of :plate_appearances_per_home_run, :allow_nil => true
  validates_numericality_of :sac_flies, :allow_nil => true, :only_integer => true
  validates_numericality_of :sac_bunts, :allow_nil => true, :only_integer => true
  validates_numericality_of :grounded_into_double_play, :allow_nil => true, :only_integer => true
  validates_numericality_of :moved_up, :allow_nil => true, :only_integer => true
  validates_numericality_of :on_base_percentage, :allow_nil => true
  validates_numericality_of :stolen_bases, :allow_nil => true, :only_integer => true
  validates_numericality_of :stolen_bases_caught, :allow_nil => true, :only_integer => true
  validates_numericality_of :stolen_bases_average, :allow_nil => true
  validates_numericality_of :hit_by_pitch, :allow_nil => true, :only_integer => true
  validates_numericality_of :defensive_interferance_reaches, :allow_nil => true, :only_integer => true
  validates_numericality_of :on_base_plus_slugging, :allow_nil => true
  validates_numericality_of :plate_appearances, :allow_nil => true, :only_integer => true
  validates_numericality_of :hits_extra_base, :allow_nil => true, :only_integer => true
end
