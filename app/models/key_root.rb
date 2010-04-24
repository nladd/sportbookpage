class KeyRoot < ActiveRecord::Base
  validates_length_of :key_type, :allow_nil => true, :maximum => 100
end
