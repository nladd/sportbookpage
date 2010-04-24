class WageringTotalScoreLine < ActiveRecord::Base
  validates_length_of :rotation_key, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
  validates_length_of :vigorish, :allow_nil => true, :maximum => 100
  validates_length_of :line_over, :allow_nil => true, :maximum => 100
  validates_length_of :line_under, :allow_nil => true, :maximum => 100
  validates_length_of :total, :allow_nil => true, :maximum => 100
  validates_length_of :total_opening, :allow_nil => true, :maximum => 100
  validates_length_of :prediction, :allow_nil => true, :maximum => 100
end
