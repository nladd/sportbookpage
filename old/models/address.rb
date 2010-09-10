class Address < ActiveRecord::Base
  validates_length_of :language, :allow_nil => true, :maximum => 100
  validates_length_of :suite, :allow_nil => true, :maximum => 100
  validates_length_of :floor, :allow_nil => true, :maximum => 100
  validates_length_of :building, :allow_nil => true, :maximum => 100
  validates_length_of :street_number, :allow_nil => true, :maximum => 100
  validates_length_of :street_prefix, :allow_nil => true, :maximum => 100
  validates_length_of :street, :allow_nil => true, :maximum => 100
  validates_length_of :street_suffix, :allow_nil => true, :maximum => 100
  validates_length_of :neighborhood, :allow_nil => true, :maximum => 100
  validates_length_of :district, :allow_nil => true, :maximum => 100
  validates_length_of :locality, :allow_nil => true, :maximum => 100
  validates_length_of :county, :allow_nil => true, :maximum => 100
  validates_length_of :region, :allow_nil => true, :maximum => 100
  validates_length_of :postal_code, :allow_nil => true, :maximum => 100
  validates_length_of :country, :allow_nil => true, :maximum => 100
end
