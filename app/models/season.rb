class Season < ActiveRecord::Base
  validates_presence_of :season_key
  validates_numericality_of :season_key, :allow_nil => false, :only_integer => true
end
