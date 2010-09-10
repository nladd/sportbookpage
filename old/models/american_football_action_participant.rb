class AmericanFootballActionParticipant < ActiveRecord::Base
  validates_presence_of :participant_role
  validates_length_of :participant_role, :allow_nil => false, :maximum => 100
  validates_length_of :score_type, :allow_nil => true, :maximum => 100
  validates_numericality_of :field_line, :allow_nil => true, :only_integer => true
  validates_numericality_of :yardage, :allow_nil => true, :only_integer => true
  validates_numericality_of :score_credit, :allow_nil => true, :only_integer => true
  validates_numericality_of :yards_gained, :allow_nil => true, :only_integer => true
end
