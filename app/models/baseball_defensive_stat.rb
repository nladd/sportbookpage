class BaseballDefensiveStat < ActiveRecord::Base
  validates_numericality_of :double_plays, :allow_nil => true, :only_integer => true
  validates_numericality_of :triple_plays, :allow_nil => true, :only_integer => true
  validates_numericality_of :putouts, :allow_nil => true, :only_integer => true
  validates_numericality_of :assists, :allow_nil => true, :only_integer => true
  validates_numericality_of :errors, :allow_nil => true, :only_integer => true
  validates_numericality_of :fielding_percentage, :allow_nil => true
  validates_numericality_of :defensive_average, :allow_nil => true
  validates_numericality_of :errors_passed_ball, :allow_nil => true, :only_integer => true
  validates_numericality_of :errors_catchers_interference, :allow_nil => true, :only_integer => true
end
