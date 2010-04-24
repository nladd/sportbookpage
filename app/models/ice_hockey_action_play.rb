class IceHockeyActionPlay < ActiveRecord::Base
  validates_length_of :play_type, :allow_nil => true, :maximum => 100
  validates_length_of :score_attempt_type, :allow_nil => true, :maximum => 100
  validates_length_of :play_result, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 255
  validates_uniqueness_of :id
end
