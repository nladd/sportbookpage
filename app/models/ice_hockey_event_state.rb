class IceHockeyEventState < ActiveRecord::Base
  validates_numericality_of :current_state, :allow_nil => true, :only_integer => true
  validates_numericality_of :sequence_number, :allow_nil => true, :only_integer => true
  validates_length_of :period_value, :allow_nil => true, :maximum => 100
  validates_length_of :period_time_elapsed, :allow_nil => true, :maximum => 100
  validates_length_of :period_time_remaining, :allow_nil => true, :maximum => 100
  validates_length_of :context, :allow_nil => true, :maximum => 40
end
