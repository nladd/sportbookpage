class BaseballActionPitch < ActiveRecord::Base
  validates_numericality_of :sequence_number, :allow_nil => true, :only_integer => true
  validates_length_of :umpire_call, :allow_nil => true, :maximum => 100
  validates_length_of :pitch_location, :allow_nil => true, :maximum => 100
  validates_length_of :pitch_type, :allow_nil => true, :maximum => 100
  validates_numericality_of :pitch_velocity, :allow_nil => true, :only_integer => true
  validates_length_of :trajectory_coordinates, :allow_nil => true, :maximum => 100
  validates_length_of :trajectory_formula, :allow_nil => true, :maximum => 100
  validates_length_of :ball_type, :allow_nil => true, :maximum => 40
  validates_length_of :strike_type, :allow_nil => true, :maximum => 40
end
