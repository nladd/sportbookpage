class Position < ActiveRecord::Base
  has_many :player_phases, :class_name => "PlayerPhase", :foreign_key => "id"

  validates_length_of :abbreviation, :allow_nil => true, :maximum => 100
end
