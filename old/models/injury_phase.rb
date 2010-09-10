class InjuryPhase < ActiveRecord::Base
  validates_length_of :injury_status, :allow_nil => true, :maximum => 100
  validates_length_of :injury_type, :allow_nil => true, :maximum => 100
  validates_length_of :injury_comment, :allow_nil => true, :maximum => 100
  validates_length_of :disabled_list, :allow_nil => true, :maximum => 100
  validates_length_of :phase_type, :allow_nil => true, :maximum => 100
  validates_length_of :injury_side, :allow_nil => true, :maximum => 100
end
