class PersonEventMetadatum < ActiveRecord::Base
  validates_length_of :status, :allow_nil => true, :maximum => 100
  validates_length_of :health, :allow_nil => true, :maximum => 100
  validates_length_of :weight, :allow_nil => true, :maximum => 100
  validates_numericality_of :lineup_slot, :allow_nil => true, :only_integer => true
  validates_numericality_of :lineup_slot_sequence, :allow_nil => true, :only_integer => true
end
