
require 'rubygems'
require 'xml/libxml'
require 'model_helpers.rb'

class Professional
  
  
  #############################################################################
  # Description:
  #   Get the standings for an affiliation
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
  def self.get_standings(affiliation_id, sub_affiliation_id, time, publisher_id)

    league = Affiliation.get_league(affiliation_id)
    scope = Affiliation.find(sub_affiliation_id).affiliation_type == 'division' ? STANDINGS_SCOPE[league.full_name] : "league"
    season_key = get_season_key(affiliation_id, time)
    
    return Standing.find(
              :all,
              :select => "teams.id AS team_id, display_names.*, 
                          outcome_totals.rank, overall_totals.wins,
                          overall_totals.losses, overall_totals.ties,
                          overall_totals.winning_percentage, outcome_totals.events_played,
                          outcome_totals.standing_points AS points,
                          outcome_totals.games_back, overall_totals.streak_type,
                          overall_totals.streak_total,
                          home_totals.wins AS home_wins, home_totals.losses AS home_losses,
                          home_totals.winning_percentage AS home_winning_percentage,
                          away_totals.wins AS away_wins, away_totals.losses AS away_losses,
                          away_totals.winning_percentage AS away_winning_percentage",
                :joins => "INNER JOIN sub_seasons ON standings.sub_season_id = sub_seasons.id 
                          INNER JOIN seasons ON sub_seasons.season_id = seasons.id 
                          INNER JOIN affiliations as standing_affiliations ON standings.affiliation_id = standing_affiliations.id 
                          INNER JOIN standing_subgroups ON standing_subgroups.standing_id = standings.id  AND standing_subgroups.alignment_scope IS NULL AND standing_subgroups.duration_scope IS NULL AND standing_subgroups.competition_scope = 'all'
                          INNER JOIN standing_subgroups AS overall_standing_subgroups ON overall_standing_subgroups.standing_id = standings.id  AND overall_standing_subgroups.alignment_scope IS NULL AND overall_standing_subgroups.duration_scope IS NULL AND overall_standing_subgroups.competition_scope = '#{scope}'
                          LEFT JOIN standing_subgroups AS home_standing_subgroups ON home_standing_subgroups.standing_id = standings.id  AND home_standing_subgroups.alignment_scope = 'events-home' AND home_standing_subgroups.duration_scope IS NULL AND home_standing_subgroups.competition_scope = '#{scope}'
                          LEFT JOIN standing_subgroups AS away_standing_subgroups ON away_standing_subgroups.standing_id = standings.id  AND away_standing_subgroups.alignment_scope = 'events-away' AND away_standing_subgroups.duration_scope IS NULL AND away_standing_subgroups.competition_scope = '#{scope}'
                          INNER JOIN affiliations as standing_subgroup_affiliations ON standing_subgroups.affiliation_id = standing_subgroup_affiliations.id AND overall_standing_subgroups.affiliation_id = standing_subgroup_affiliations.id 
                          INNER JOIN outcome_totals ON outcome_totals.standing_subgroup_id = standing_subgroups.id 
                          INNER JOIN outcome_totals AS overall_totals ON overall_totals.standing_subgroup_id = overall_standing_subgroups.id AND overall_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                          INNER JOIN outcome_totals AS home_totals ON home_totals.standing_subgroup_id = home_standing_subgroups.id AND home_totals.outcome_holder_id = outcome_totals.outcome_holder_id
                          INNER JOIN outcome_totals AS away_totals ON away_totals.standing_subgroup_id = away_standing_subgroups.id AND away_totals.outcome_holder_id = outcome_totals.outcome_holder_id    
                          INNER JOIN teams ON outcome_totals.outcome_holder_id = teams.id 
                          INNER JOIN display_names ON (display_names.entity_id = teams.id AND display_names.entity_type = 'teams')",
                :conditions => "seasons.publisher_id = #{publisher_id} AND
                               sub_seasons.sub_season_type = 'season-regular' AND
                               seasons.season_key = #{season_key} AND
                               standings.affiliation_id = #{affiliation_id} AND
                               overall_standing_subgroups.affiliation_id = #{sub_affiliation_id}",
                :order => "outcome_totals.rank + 0")
  
  end


end