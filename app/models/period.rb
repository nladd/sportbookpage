class Period < ActiveRecord::Base
  validates_length_of :period_value, :allow_nil => true, :maximum => 100
  validates_length_of :score, :allow_nil => true, :maximum => 100
end
