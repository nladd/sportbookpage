class CoreStat < ActiveRecord::Base
  validates_length_of :score, :allow_nil => true, :maximum => 100
  validates_length_of :score_opposing, :allow_nil => true, :maximum => 100
  validates_length_of :score_attempts, :allow_nil => true, :maximum => 100
  validates_length_of :score_attempts_opposing, :allow_nil => true, :maximum => 100
  validates_length_of :score_percentage, :allow_nil => true, :maximum => 100
  validates_length_of :score_percentage_opposing, :allow_nil => true, :maximum => 100
end
