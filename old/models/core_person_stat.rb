class CorePersonStat < ActiveRecord::Base
  validates_length_of :time_played_event, :allow_nil => true, :maximum => 40
  validates_length_of :time_played_total, :allow_nil => true, :maximum => 40
  validates_length_of :time_played_event_average, :allow_nil => true, :maximum => 40
  validates_numericality_of :events_played, :allow_nil => true, :only_integer => true
  validates_numericality_of :events_started, :allow_nil => true, :only_integer => true
end
