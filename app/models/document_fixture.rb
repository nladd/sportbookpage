class DocumentFixture < ActiveRecord::Base
  validates_length_of :fixture_key, :allow_nil => true, :maximum => 100
  validates_length_of :name, :allow_nil => true, :maximum => 100
end
