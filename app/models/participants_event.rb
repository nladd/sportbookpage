class ParticipantsEvent < ActiveRecord::Base

  belongs_to :events, :class_name => "Event", :foreign_key => "event_id"

  validates_presence_of :participant_type
  validates_length_of :participant_type, :allow_nil => false, :maximum => 100
  validates_length_of :alignment, :allow_nil => true, :maximum => 100
  validates_length_of :score, :allow_nil => true, :maximum => 100
  validates_length_of :event_outcome, :allow_nil => true, :maximum => 100
  validates_numericality_of :rank, :allow_nil => true, :only_integer => true
end
