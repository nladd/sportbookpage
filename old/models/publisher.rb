class Publisher < ActiveRecord::Base
  validates_presence_of :publisher_key
  validates_length_of :publisher_key, :allow_nil => false, :maximum => 100
  validates_length_of :publisher_name, :allow_nil => true, :maximum => 100
end
