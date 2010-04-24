class WageringRunline < ActiveRecord::Base
  validates_length_of :rotation_key, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
  validates_length_of :vigorish, :allow_nil => true, :maximum => 100
  validates_length_of :line, :allow_nil => true, :maximum => 100
  validates_length_of :line_opening, :allow_nil => true, :maximum => 100
  validates_length_of :line_value, :allow_nil => true, :maximum => 100
  validates_length_of :prediction, :allow_nil => true, :maximum => 100
end
