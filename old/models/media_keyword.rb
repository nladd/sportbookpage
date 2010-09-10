class MediaKeyword < ActiveRecord::Base
  validates_length_of :keyword, :allow_nil => true, :maximum => 100
end
