
require 'rubygems'
require 'xml/libxml'
require 'model_helpers.rb'


class College
  
  
  #############################################################################
  # Description:
  #   Get the standings for an NCAA conference
  #
  # Params:
  #   -affiliation_id - int - id of the league to which the sub_affiliation belongs to
  #   -sub_affiliation_id - int - id of the sub affiliation (conference)
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #   -publisher_id - int - id of the publisher of the data
  #                   NOTE: This parameter is optional. Default: PUBLISHER_ID env variable
  #
  # Return:
  #   :select => "affiliations.id as affiliation_id,
  #               standing_subgroup_affiliations.id as division_id,
  #               teams.id AS team_id,      
  #               outcome_totals.*,
  #               display_names.*",
  #############################################################################
  def self.get_standings(affiliation_id, sub_affiliation_id, time, publisher_id)

    league = Affiliation.get_league(affiliation_id)    
    scope = STANDINGS_SCOPE[league.full_name]
    doc_fixture_id = DocumentFixture.find_by_fixture_key('poll-ap').id

    season_key = get_season_key(affiliation_id, time)
        
    return Standing.find(
              :all,
              :select => "teams.id AS team_id, display_names.*,
                    outcome_totals.rank,
                    league_totals.losses AS league_losses,
                    league_totals.winning_percentage AS league_winning_percentage,
                    conference_totals.wins AS conference_wins,
                    conference_totals.losses AS conference_losses,
                    conference_totals.winning_percentage AS conference_winning_percentage,
                    outcome_totals.events_played,
                    outcome_totals.games_back, outcome_totals.streak_type,
                    home_wins, home_losses,
                    away_wins, away_losses,
                    outcome_totals.streak_total, rankings.ranking_value,
                    rankings.ranking_value_previous AS previous_ranking_value",
              :joins => "INNER JOIN standing_subgroups ON standing_subgroups.standing_id = standings.id AND standing_subgroups.competition_scope = 'all'
                      INNER JOIN standing_subgroups AS league_standing_subgroups ON league_standing_subgroups.standing_id = standings.id AND league_standing_subgroups.competition_scope = 'league'
                      INNER JOIN standing_subgroups AS conference_standing_subgroups ON conference_standing_subgroups.standing_id = standings.id AND conference_standing_subgroups.competition_scope = 'conference'
                      INNER JOIN outcome_totals ON outcome_totals.standing_subgroup_id = standing_subgroups.id 
                      INNER JOIN outcome_totals AS league_totals ON league_totals.standing_subgroup_id = league_standing_subgroups.id AND league_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                      INNER JOIN outcome_totals AS conference_totals ON conference_totals.standing_subgroup_id = conference_standing_subgroups.id AND conference_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                      INNER JOIN sub_seasons ON standings.sub_season_id = sub_seasons.id 
                      INNER JOIN seasons ON sub_seasons.season_id = seasons.id 
                      INNER JOIN affiliations as league_affiliations ON seasons.league_id = league_affiliations.id 
                      INNER JOIN affiliations as standing_affiliations ON standings.affiliation_id = standing_affiliations.id 
                      INNER JOIN affiliations as standing_subgroup_affiliations ON standing_subgroups.affiliation_id = standing_subgroup_affiliations.id  
                      INNER JOIN affiliations as season_affiliations ON seasons.league_id = season_affiliations.id
                      INNER JOIN teams ON outcome_totals.outcome_holder_id = teams.id
                      LEFT JOIN rankings ON rankings.participant_id = teams.id AND rankings.document_fixture_id = #{doc_fixture_id} AND rankings.date_coverage_id = sub_seasons.id  AND ranking_type = 'rank'
                      INNER JOIN publishers ON seasons.publisher_id = publishers.id  
                      INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
              :conditions => "league_affiliations.id = #{affiliation_id} AND
                             standing_affiliations.id = #{sub_affiliation_id} AND
                             standing_affiliations.affiliation_type = 'conference' AND
                             seasons.season_key = #{season_key} AND
                             sub_seasons.sub_season_type = 'season-regular' AND
                             outcome_totals.outcome_holder_type = 'teams' AND
                             rankings.document_fixture_id = 120 AND
                             publishers.id = #{publisher_id}",
              :order => "outcome_totals.rank + 0")
        
    
    
  end
  
  
  #############################################################################
  # Description:
  #   Get the rankings for an NCAA league
  #
  # Params:
  #   -affiliation_id - int - id of the league to which the sub_affiliation belongs to
  #   -sub_affiliation_id - int - id of the sub affiliation (conference/division id)
  #   -time - Time - return results for the season that contains time
  #                 NOTE: This is an optional parameter that defaults to the env variable TIME
  #
  # Return:
  #   :select => "affiliations.id as affiliation_id,
  #               standing_subgroup_affiliations.id as division_id,
  #               teams.id AS team_id,      
  #               outcome_totals.*,
  #               display_names.*",
  #############################################################################
  def self.get_rankings(affiliation_id, time, publisher_id)

    doc_fixture_id = DocumentFixture.find_by_fixture_key('poll-ap').id

    season_key = get_season_key(affiliation_id, time)                        
                 
    ActiveRecord::Base.connection.execute("SET sql_big_selects=1")
                        
    return Standing.find(
                :all,
                :select => "teams.id AS team_id, display_names.*, 
                           rankings.ranking_value AS rank, 
                           rankings.ranking_value_previous AS previous_rank, 
                           league_totals.wins AS wins,
                           league_totals.losses AS losses,
                           league_totals.winning_percentage AS winning_percentage,
                           conference_totals.wins AS conference_wins,
                           conference_totals.losses AS conference_losses,
                           conference_totals.winning_percentage AS conference_winning_percentage,
                           outcome_totals.events_played, outcome_totals.games_back,
                           outcome_totals.streak_type, outcome_totals.streak_total",
                :joins => "INNER JOIN standing_subgroups ON standing_subgroups.standing_id = standings.id AND standing_subgroups.competition_scope = 'all'
                          INNER JOIN standing_subgroups AS league_standing_subgroups ON league_standing_subgroups.standing_id = standings.id AND league_standing_subgroups.competition_scope = 'league'
                          INNER JOIN standing_subgroups AS conference_standing_subgroups ON conference_standing_subgroups.standing_id = standings.id AND conference_standing_subgroups.competition_scope = 'conference'
                          INNER JOIN outcome_totals ON outcome_totals.standing_subgroup_id = standing_subgroups.id   
                          INNER JOIN outcome_totals AS league_totals ON league_totals.standing_subgroup_id = league_standing_subgroups.id AND league_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                          INNER JOIN outcome_totals AS conference_totals ON conference_totals.standing_subgroup_id = conference_standing_subgroups.id AND conference_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                          INNER JOIN sub_seasons ON standings.sub_season_id = sub_seasons.id   
                          INNER JOIN seasons ON sub_seasons.season_id = seasons.id   
                          INNER JOIN affiliations as league_affiliations ON seasons.league_id = league_affiliations.id  
                          INNER JOIN affiliations as standing_subgroup_affiliations ON standing_subgroups.affiliation_id = standing_subgroup_affiliations.id   
                          INNER JOIN affiliations as season_affiliations ON seasons.league_id = season_affiliations.id  
                          INNER JOIN teams ON outcome_totals.outcome_holder_id = teams.id 
                          INNER JOIN rankings ON rankings.participant_id = teams.id AND rankings.document_fixture_id = #{doc_fixture_id} AND rankings.date_coverage_id = sub_seasons.id  AND ranking_type = 'rank' 
                          INNER JOIN publishers ON seasons.publisher_id = publishers.id   
                          INNER JOIN display_names ON display_names.entity_id = teams.id AND display_names.entity_type = 'teams'",
                :conditions => "league_affiliations.id = #{affiliation_id} AND
                               seasons.season_key = #{season_key} AND
                               sub_seasons.sub_season_type = 'season-regular' AND
                               outcome_totals.outcome_holder_type = 'teams' AND  
                               publishers.id = #{publisher_id}",
                :order => "rankings.ranking_value + 0")
    
                        
  end
  
  
end