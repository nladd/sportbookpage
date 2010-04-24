class DocumentContent < ActiveRecord::Base
  validates_length_of :sportsml, :allow_nil => true, :maximum => 200
end
