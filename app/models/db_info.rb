class DbInfo < ActiveRecord::Base
  validates_presence_of :version
  validates_length_of :version, :allow_nil => false, :maximum => 100
end
