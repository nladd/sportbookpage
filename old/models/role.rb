class Role < ActiveRecord::Base
  validates_presence_of :role_key
  validates_length_of :role_key, :allow_nil => false, :maximum => 100
  validates_length_of :role_name, :allow_nil => true, :maximum => 100
  validates_length_of :comment, :allow_nil => true, :maximum => 100
end
