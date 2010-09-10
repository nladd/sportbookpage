class Bookmaker < ActiveRecord::Base
  validates_length_of :bookmaker_key, :allow_nil => true, :maximum => 100
end
