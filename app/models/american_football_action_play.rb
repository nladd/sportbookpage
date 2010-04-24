class AmericanFootballActionPlay < ActiveRecord::Base
  validates_length_of :play_type, :allow_nil => true, :maximum => 100
  validates_length_of :score_attempt_type, :allow_nil => true, :maximum => 100
  validates_length_of :drive_result, :allow_nil => true, :maximum => 100
  validates_numericality_of :points, :allow_nil => true, :only_integer => true
  validates_length_of :comment, :allow_nil => true, :maximum => 255
end
