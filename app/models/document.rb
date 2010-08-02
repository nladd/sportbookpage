###############################################################################
# Description:
#   Stores and retrieves documents
#
###############################################################################
class Document < ActiveRecord::Base
  validates_length_of :title, :allow_nil => true, :maximum => 255
  validates_length_of :language, :allow_nil => true, :maximum => 100
  validates_length_of :priority, :allow_nil => true, :maximum => 100
  validates_length_of :stats_coverage, :allow_nil => true, :maximum => 100
  
  #############################################################################
  # Description:
  #   Get a document by it's document_id
  #
  # Params:
  #   -document_id - int - id of the document
  #
  # Return:
  #   :select => "document_contents.*, documents.*"
  #############################################################################
  def self.get_document(document_id)
    
    return Document.find_by_id(
                      document_id,
                      :select => "documents.*, document_contents.*, CONVERT_TZ(documents.date_time, '+00:00', '#{TIMEZONE}') AS date_time",
                      :joins => "INNER JOIN document_contents ON document_contents.document_id = #{document_id}"
    )
  
  end
  
  #############################################################################
  # Description:
  #   Get all documents related to a league by fixture key
  #
  # Params:
  #   -league_id - int - id of the league
  #   -fixture_key - string - document fixture key
  #   -order - string - SQL syntzx string specifying the order to return the results
  #                     Note: This is an optional parameter that defaults to 
  #                     "documents.date_time DESC"
  #   -limit - int - the number of results to return. 
  #                  Note: This is an optional parameter that default to 5
  #
  # Return:
  #   :select => "document_contents.*, documents.*"
  #############################################################################
  def self.get_league_docs_by_fixture_key(league_id, fixture_key, limit = 5,
                                order = "documents.date_time DESC")
    
    return AffiliationsDocument.find_all_by_affiliation_id(
                    league_id,
                    :select => "dc.*, documents.*, documents.date_time AS dt, CONVERT_TZ(documents.date_time, '+00:00', '#{TIMEZONE}') AS date_time",
                    :joins => "INNER JOIN documents ON documents.id = affiliations_documents.document_id
                              INNER JOIN document_contents AS dc ON dc.document_id = affiliations_documents.document_id
                              INNER JOIN document_fixtures AS df ON df.id = documents.document_fixture_id AND df.fixture_key = '#{fixture_key}'",
                    :group => "documents.revision_id",
                    :order => order,
                    :limit => limit)
  
  end
  
  
  #############################################################################
  # Description:
  #   Get all documents related to a team by fixture key
  #
  # Params:
  #   -team_id - int - id of the team
  #   -fixture_key - string - document fixture key
  #   -order - string - SQL syntzx string specifying the order to return the results
  #                     Note: This is an optional parameter that defaults to 
  #                     "documents.date_time DESC"
  #   -limit - int - the number of results to return. 
  #                  Note: This is an optional parameter that default to 5
  #
  # Return:
  #   :select => "document_contents.*, documents.*"
  #############################################################################
  def self.get_team_docs_by_fixture_key(team_id, fixture_key, limit = 5, 
                                                    order = "documents.date_time DESC")
      
    return TeamsDocument.find(
                    :all,
                    :select => "dc.*, documents.*, documents.date_time AS dt, CONVERT_TZ(documents.date_time, '+00:00', '#{TIMEZONE}') AS date_time",
                    :from => "teams_documents AS td",
                    :joins => "INNER JOIN documents ON documents.id = td.document_id
                              INNER JOIN document_contents AS dc ON dc.document_id = td.document_id
                              INNER JOIN document_fixtures AS df ON df.id = documents.document_fixture_id AND (df.fixture_key = '#{fixture_key}')",
                    :conditions => "td.team_id = #{team_id}",
                    :group => "documents.revision_id",
                    :order => order,
                    :limit => limit)
  
  end

  
  #############################################################################
  # Description:
  #   Get all documents related to a person by fixture key
  #
  # Params:
  #   -person_id - int - id of the person
  #   -fixture_key - string - document fixture key
  #   -order - string - SQL syntzx string specifying the order to return the results
  #                     Note: This is an optional parameter that defaults to 
  #                     "documents.date_time DESC"
  #   -limit - int - the number of results to return. 
  #                  Note: This is an optional parameter that default to 5
  #
  # Return:
  #   :select => "document_contents.*, documents.*"
  #############################################################################
  def self.get_person_docs_by_fixture_key(person_id, fixture_key, limit = 5,
                                              order = "documents.date_time DESC")
    
    return PersonsDocument.find(
                    :all,
                    :select => "dc.*, documents.*, documents.date_time AS dt, CONVERT_TZ(documents.date_time, '+00:00', '#{TIMEZONE}') AS date_time",
                    :from => "persons_documents AS pd",
                    :joins => "INNER JOIN documents ON documents.id = pd.document_id
                              INNER JOIN document_contents AS dc ON dc.document_id = pd.document_id
                              INNER JOIN document_fixtures AS df ON df.id = documents.document_fixture_id AND df.fixture_key = '#{fixture_key}'",
                    :conditions => "pd.person_id = #{person_id}",
                    :group => "revision_id",
                    :order => order,
                    :limit => limit)
  
  end
  
  
  #############################################################################
  # Description:
  #   Get all documents related to an event by fixture key
  #
  # Params:
  #   -event_id - int - id of the event
  #   -fixture_key - string - document fixture key
  #   -order - string - SQL syntzx string specifying the order to return the results
  #                     Note: This is an optional parameter that defaults to 
  #                     "documents.date_time DESC"
  #   -limit - int - the number of results to return. 
  #                  Note: This is an optional parameter that default to 5
  #
  # Return:
  #   :select => "document_contents.*, documents.*"
  #############################################################################
  def self.get_event_docs_by_fixture_key(event_id, fixture_key, order = "documents.date_time DESC", limit = 5)
    
    return EventsDocument.find(
                    :all,
                    :select => "dc.*, documents.*, documents.date_time AS dt, CONVERT_TZ(documents.date_time, '+00:00', '#{TIMEZONE}') AS date_time",
                    :from => "events_documents AS ed",
                    :joins => "INNER JOIN documents ON documents.id = ed.document_id
                              INNER JOIN document_contents AS dc ON dc.document_id = ed.document_id
                              INNER JOIN document_fixtures AS df ON df.id = documents.document_fixture_id AND df.fixture_key = '#{fixture_key}'",
                    :conditions => "ed.event_id = #{event_id}",
                    :group => "revision_id",
                    :order => order,
                    :limit => limit)
  
  end
  
  
  
end
