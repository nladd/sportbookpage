class Site < ActiveRecord::Base
  validates_presence_of :site_key
  validates_numericality_of :site_key, :allow_nil => false, :only_integer => true
end
