class BaseballEventState < ActiveRecord::Base
  validates_numericality_of :current_state, :allow_nil => true, :only_integer => true
  validates_numericality_of :sequence_number, :allow_nil => true, :only_integer => true
  validates_numericality_of :at_bat_number, :allow_nil => true, :only_integer => true
  validates_numericality_of :inning_value, :allow_nil => true, :only_integer => true
  validates_length_of :inning_half, :allow_nil => true, :maximum => 100
  validates_numericality_of :outs, :allow_nil => true, :only_integer => true
  validates_numericality_of :balls, :allow_nil => true, :only_integer => true
  validates_numericality_of :strikes, :allow_nil => true, :only_integer => true
  validates_numericality_of :runner_on_first, :allow_nil => true, :only_integer => true
  validates_numericality_of :runner_on_second, :allow_nil => true, :only_integer => true
  validates_numericality_of :runner_on_third, :allow_nil => true, :only_integer => true
  validates_numericality_of :runs_this_inning_half, :allow_nil => true, :only_integer => true
  validates_length_of :batter_side, :allow_nil => true, :maximum => 100
  validates_length_of :context, :allow_nil => true, :maximum => 40
end
