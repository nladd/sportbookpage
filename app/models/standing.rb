class Standing < ActiveRecord::Base

  belongs_to :affilations, :class_name => "Affiliation", :foreign_key => "affiliation_id"
  belongs_to :sub_seasons, :class_name => "SubSeason", :foreign_key => "sub_season_id"

  validates_length_of :standing_type, :allow_nil => true, :maximum => 100
  validates_length_of :last_updated, :allow_nil => true, :maximum => 100
  validates_length_of :duration_scope, :allow_nil => true, :maximum => 100
  validates_length_of :competition_scope, :allow_nil => true, :maximum => 100
  validates_length_of :alignment_scope, :allow_nil => true, :maximum => 100
  validates_length_of :site_scope, :allow_nil => true, :maximum => 100
  validates_length_of :scoping_label, :allow_nil => true, :maximum => 100
  validates_length_of :source, :allow_nil => true, :maximum => 100
end
