class DisplayName < ActiveRecord::Base

  validates_presence_of :language
  validates_length_of :language, :allow_nil => false, :maximum => 100
  validates_presence_of :entity_type
  validates_length_of :entity_type, :allow_nil => false, :maximum => 100
  validates_length_of :full_name, :allow_nil => true, :maximum => 100
  validates_length_of :first_name, :allow_nil => true, :maximum => 100
  validates_length_of :middle_name, :allow_nil => true, :maximum => 100
  validates_length_of :last_name, :allow_nil => true, :maximum => 100
  validates_length_of :alias, :allow_nil => true, :maximum => 100
  validates_length_of :abbreviation, :allow_nil => true, :maximum => 100
  validates_length_of :short_name, :allow_nil => true, :maximum => 100
  validates_length_of :prefix, :allow_nil => true, :maximum => 20
  validates_length_of :suffix, :allow_nil => true, :maximum => 20
  
  
  ##############################################################################
  # Description:
  #   Gets the display name for an entity including league names, team names, and individual
  #   players names from the entity's id and type. The id is specified by the id attribute of the
  #   entity's table and participant_type is defined by the entity's table name. 
  #
  # Params:
  #   -ids -  A single id or an array of ids for the entity(ies) to get the display_name 
  #           for as defined by the id attribute of the entity's table
  #   -participant_type - The participant type of the entity as defined by the entity's table name
  #
  #
  # Return:
  # -DisplayName[] - Array DisplayName objects
  #############################################################################
  def self.get_display_name_by_ids(ids, participant_type)
    DisplayName.find_all_by_entity_id(ids, :conditions => "entity_type = '#{participant_type}'")
  end

  
  
  
end
