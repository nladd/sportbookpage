class IceHockeyActionParticipant < ActiveRecord::Base
  validates_presence_of :participant_role
  validates_length_of :participant_role, :allow_nil => false, :maximum => 100
  validates_numericality_of :point_credit, :allow_nil => true, :only_integer => true
  validates_uniqueness_of :id
end
