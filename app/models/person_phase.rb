class PersonPhase < ActiveRecord::Base
  belongs_to :persons, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :roles, :class_name => "Role", :foreign_key => "role_id"
  belongs_to :positions, :class_name => "Position", :foreign_key => "regular_position_id"
  belongs_to :seasons, :class_name => "Season", :foreign_key => "start_season_id"
  belongs_to :seasons, :class_name => "Season", :foreign_key => "end_season_id"  

  validates_presence_of :membership_type
  validates_length_of :membership_type, :allow_nil => false, :maximum => 40
  validates_length_of :role_status, :allow_nil => true, :maximum => 40
  validates_length_of :phase_status, :allow_nil => true, :maximum => 40
  validates_length_of :uniform_number, :allow_nil => true, :maximum => 20
  validates_length_of :regular_position_depth, :allow_nil => true, :maximum => 40
  validates_length_of :height, :allow_nil => true, :maximum => 100
  validates_length_of :weight, :allow_nil => true, :maximum => 100
  validates_length_of :entry_reason, :allow_nil => true, :maximum => 40
  validates_length_of :exit_reason, :allow_nil => true, :maximum => 40
  validates_numericality_of :selection_level, :allow_nil => true, :only_integer => true
  validates_numericality_of :selection_sublevel, :allow_nil => true, :only_integer => true
  validates_numericality_of :selection_overall, :allow_nil => true, :only_integer => true
  
 
  
end
