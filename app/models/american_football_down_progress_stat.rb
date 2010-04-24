class AmericanFootballDownProgressStat < ActiveRecord::Base
  validates_length_of :first_downs_total, :allow_nil => true, :maximum => 100
  validates_length_of :first_downs_pass, :allow_nil => true, :maximum => 100
  validates_length_of :first_downs_run, :allow_nil => true, :maximum => 100
  validates_length_of :first_downs_penalty, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_third_down, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_third_down_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_third_down_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_fourth_down, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_fourth_down_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :conversions_fourth_down_percentage, :allow_nil => true, :maximum => 100
end
