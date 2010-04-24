class StandingSubgroup < ActiveRecord::Base

  has_many :outcome_totals, :class_name => "OutcomeTotal", :foreign_key => "standing_subgroup_id"
  has_many :affiliations, :class_name => "Affiliation", :foreign_key => "affiliation_id"
  
  validates_presence_of :standing_id
  validates_presence_of :affilation_id
  validates_length_of :alignment_scope, :allow_nil => true, :maximum => 100
  validates_length_of :competition_scope, :allow_nil => true, :maximum => 100
  validates_length_of :competition_scope_id, :allow_nil => true, :maximum => 100
  validates_length_of :duration_scope, :allow_nil => true, :maximum => 100
  validates_length_of :site_scope, :allow_nil => true, :maximum => 100
  
  
end
