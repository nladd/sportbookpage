class SubSeason < ActiveRecord::Base

  has_many :standings, :class_name => "Standing", :foreign_key => "sub_season_id"

  validates_presence_of :sub_season_key
  validates_length_of :sub_season_key, :allow_nil => false, :maximum => 100
  validates_presence_of :sub_season_type
  validates_length_of :sub_season_type, :allow_nil => false, :maximum => 100
end
