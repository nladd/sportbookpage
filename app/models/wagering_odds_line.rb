class WageringOddsLine < ActiveRecord::Base
  validates_length_of :rotation_key, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
  validates_length_of :numerator, :allow_nil => true, :maximum => 100
  validates_length_of :denominator, :allow_nil => true, :maximum => 100
  validates_length_of :prediction, :allow_nil => true, :maximum => 100
  validates_length_of :payout_calculation, :allow_nil => true, :maximum => 100
  validates_length_of :payout_amount, :allow_nil => true, :maximum => 100
end
