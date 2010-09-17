
class NameLookup
  
  @@leagues = Hash.new
  @@conferences = Hash.new
  @@divisions = Hash.new
  @@teams = Hash.new
  
  def initialize
    temp_leagues = Affiliation.get_all_leagues()
    temp_leagues.each do |temp_league|
      @@leagues.store(temp_league.affiliation_id.to_i, temp_league)
      
      temp_conferences = Affiliation.find_all_by_affiliation_type(
                        "conference",
                        :select => "affiliations.id AS affiliation_id, affiliations.affiliation_key, affiliations.affiliation_type, display_names.*",
                        :joins => "INNER JOIN affiliation_phases ON affiliation_phases.ancestor_affiliation_id = #{temp_league.affiliation_id} AND affiliation_phases.affiliation_id = affiliations.id
                                  INNER JOIN display_names ON display_names.entity_id = affiliations.id AND display_names.entity_type = 'affiliations'",
                        :conditions => "affiliations.publisher_id = #{PUBLISHER_ID}")
      temp_conferences.each do |temp_conference|
        @@conferences.store(temp_conference.affiliation_id.to_i, temp_conference)
      end
      
      temp_divisions = AffiliationPhase.find_all_by_root_id(
                        temp_league.affiliation_id,
                        :select => "divisions.id AS affiliation_id, divisions.affiliation_key AS affiliation_key, conferences.id AS conference_id, conferences.affiliation_key AS conference_key, display_names.*",
                        :joins => "INNER JOIN affiliations AS divisions ON affiliation_phases.affiliation_id = divisions.id AND divisions.affiliation_type = 'division'  
                                   INNER JOIN affiliations AS conferences ON conferences.affiliation_type = 'conference'  
                                   INNER JOIN affiliation_phases AS conference_ap ON conference_ap.root_id = #{temp_league.affiliation_id} AND conference_ap.ancestor_affiliation_id = conferences.id AND conference_ap.affiliation_id = divisions.id
                                   INNER JOIN display_names ON display_names.entity_id = divisions.id AND display_names.entity_type = 'affiliations'",
                        :conditions => "divisions.publisher_id = #{PUBLISHER_ID} AND conferences.publisher_id = #{PUBLISHER_ID} AND affiliation_phases.ancestor_affiliation_id = conferences.id")
      temp_divisions.each do |temp_division|
        @@divisions.store(temp_division.affiliation_id.to_i, temp_division)
      end
      
      affiliation_key = temp_league.affiliation_key
      # college football needs to be treated as a special case
      if (affiliation_key == "l.ncaa.org.mfoot.div1.aa" || affiliation_key == "l.ncaa.org.mfoot.div2" || affiliation_key == "l.ncaa.org.mfoot.div3")
        affiliation_key = "l.ncaa.org.mfoot"
      end
      
      temp_teams = Affiliation.find_all_by_affiliation_type(
                        "league",
                        :select => "teams.id AS team_id, teams.team_key, teams.followers, display_names.*",
                        :joins => "INNER JOIN teams
                                  INNER JOIN team_phases ON team_phases.team_id = teams.id AND  team_phases.affiliation_id = affiliations.id AND team_phases.affiliation_id = #{temp_league.affiliation_id} 
                                  INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
                        :conditions => "display_names.full_name <> 'To Be Announced' AND teams.team_key LIKE '#{affiliation_key}%' AND  affiliations.publisher_id = #{PUBLISHER_ID}")
      temp_teams.each do |temp_team|
        @@teams.store(temp_team.team_id.to_i, temp_team)
      end
      
    end
    
  end
  
  def league_first_name(id)
    retStr = ""
    retStr = @@leagues[id.to_i].first_name if @@leagues.has_key?(id.to_i)
    
    return retStr
  end
  
  def league_last_name(id)
    retStr = ""
    retStr = @@leagues[id.to_i].last_name if @@leagues.has_key?(id.to_i)
    
    return retStr
  end
  
  def league_full_name(id)
    retStr = ""
    retStr = @@leagues[id.to_i].full_name if @@leagues.has_key?(id.to_i)
    
    return retStr
  end
  
  def league_abbreviation(id)
    retStr = ""
    retStr = @@leagues[id.to_i].abbreviation if @@leagues.has_key?(id.to_i)
    
    return retStr
  end
  
  def conference_first_name(id)
    retStr = ""
    retStr = @@conferences[id.to_i].first_name if @@conferences.has_key?(id.to_i)
    
    return retStr
  end
  
  def conference_last_name(id)
    retStr = ""
    retStr = @@conferences[id.to_i].last_name if @@conferences.has_key?(id.to_i)
    
    return retStr
  end
  
  def conference_full_name(id)
    retStr = ""
    retStr = @@conferences[id.to_i].full_name if @@conferences.has_key?(id.to_i)
    
    return retStr
  end
  
  def conference_abbreviation(id)
    retStr = ""
    retStr = @@conferences[id.to_i].abbreviation if @@conferences.has_key?(id.to_i)
    
    return retStr
  end
  
  def division_first_name(id)
    retStr = ""
    retStr = @@divisions[id.to_i].first_name if @@divisions.has_key?(id.to_i)
    
    return retStr
  end
  
  def division_last_name(id)
    retStr = ""
    retStr = @@divisions[id.to_i].last_name if @@divisions.has_key?(id.to_i)
    
    return retStr
  end
  
  def division_full_name(id)
    retStr = ""
    retStr = @@divisions[id.to_i].full_name if @@divisions.has_key?(id.to_i)
    
    return retStr
  end
  
  def division_abbreviation(id)
    retStr = ""
    retStr = @@divisions[id.to_i].abbreviation if @@divisions.has_key?(id.to_i)
    
    return retStr
  end
  
  def team_first_name(id)
    retStr = ""
    retStr = @@teams[id.to_i].first_name if @@teams.has_key?(id.to_i)
    
    return retStr
  end
  
  def team_last_name(id)
    retStr = ""
    retStr = @@teams[id.to_i].last_name if @@teams.has_key?(id.to_i)

    return retStr
  end
  
  def team_full_name(id)
    retStr = ""
    retStr = @@teams[id.to_i].full_name if @@teams.has_key?(id.to_i)
    
    return retStr
  end
  
  def team_abbreviation(id)
    retStr = ""
    retStr = @@teams[id.to_i].abbreviation if @@teams.has_key?(id.to_i)
    
    return retStr
  end
  
end
