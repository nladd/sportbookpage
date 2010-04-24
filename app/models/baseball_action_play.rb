class BaseballActionPlay < ActiveRecord::Base
  validates_length_of :play_type, :allow_nil => true, :maximum => 100
  validates_length_of :notation, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 255
  validates_numericality_of :runner_on_first_advance, :allow_nil => true, :only_integer => true
  validates_numericality_of :runner_on_second_advance, :allow_nil => true, :only_integer => true
  validates_numericality_of :runner_on_third_advance, :allow_nil => true, :only_integer => true
  validates_numericality_of :outs_recorded, :allow_nil => true, :only_integer => true
  validates_numericality_of :rbi, :allow_nil => true, :only_integer => true
  validates_numericality_of :runs_scored, :allow_nil => true, :only_integer => true
  validates_length_of :earned_runs_scored, :allow_nil => true, :maximum => 100
end
