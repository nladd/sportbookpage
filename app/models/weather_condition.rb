class WeatherCondition < ActiveRecord::Base
  validates_length_of :temperature, :allow_nil => true, :maximum => 100
  validates_length_of :temperature_units, :allow_nil => true, :maximum => 40
  validates_length_of :humidity, :allow_nil => true, :maximum => 100
  validates_length_of :clouds, :allow_nil => true, :maximum => 100
  validates_length_of :wind_direction, :allow_nil => true, :maximum => 100
  validates_length_of :wind_velocity, :allow_nil => true, :maximum => 100
  validates_length_of :weather_code, :allow_nil => true, :maximum => 100
end
