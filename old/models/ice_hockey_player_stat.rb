class IceHockeyPlayerStat < ActiveRecord::Base
  validates_length_of :plus_minus, :allow_nil => true, :maximum => 100
end
