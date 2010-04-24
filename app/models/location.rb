class Location < ActiveRecord::Base
  validates_length_of :timezone, :allow_nil => true, :maximum => 100
  validates_length_of :latitude, :allow_nil => true, :maximum => 100
  validates_length_of :longitude, :allow_nil => true, :maximum => 100
  validates_length_of :country_code, :allow_nil => true, :maximum => 100
end
