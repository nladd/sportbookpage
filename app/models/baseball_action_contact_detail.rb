class BaseballActionContactDetail < ActiveRecord::Base
  validates_length_of :location, :allow_nil => true, :maximum => 100
  validates_length_of :strength, :allow_nil => true, :maximum => 100
  validates_numericality_of :velocity, :allow_nil => true, :only_integer => true
  validates_length_of :trajectory_coordinates, :allow_nil => true, :maximum => 100
  validates_length_of :trajectory_formula, :allow_nil => true, :maximum => 100
end
