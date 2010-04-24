class BaseballActionSubstitution < ActiveRecord::Base
  validates_numericality_of :sequence_number, :allow_nil => true, :only_integer => true
  validates_length_of :person_type, :allow_nil => true, :maximum => 100
  validates_numericality_of :person_original_lineup_slot, :allow_nil => true, :only_integer => true
  validates_numericality_of :person_replacing_lineup_slot, :allow_nil => true, :only_integer => true
  validates_length_of :substitution_reason, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
end
