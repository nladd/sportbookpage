class Medium < ActiveRecord::Base
  validates_length_of :media_type, :allow_nil => true, :maximum => 100
  validates_length_of :date_time, :allow_nil => true, :maximum => 100
end
