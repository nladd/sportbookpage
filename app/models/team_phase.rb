class TeamPhase < ActiveRecord::Base

  belongs_to :teams, :class_name => "Team", :foreign_key => "team_id"
  belongs_to :affiliations, :class_name => "Affiliation", :foreign_key => "affiliation_id"

  validates_length_of :start_date_time, :allow_nil => true, :maximum => 100
  validates_length_of :end_date_time, :allow_nil => true, :maximum => 100
  validates_length_of :phase_status, :allow_nil => true, :maximum => 40
end
