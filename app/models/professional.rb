
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
  #############################################################################
  def self.get_standings(affiliation_id, sub_affiliation_id, time = TIME, publisher_id = PUBLISHER_ID)

    league = Affiliation.get_league(affiliation_id)
    scope = Affiliation.find(sub_affiliation_id).affiliation_type == 'division' ? STANDINGS_SCOPE[league.full_name] : "league"
    season_key = get_season_key(affiliation_id, time)
    
    return Standing.find(
              :all,
              :select => "teams.id AS team_id,
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
                          INNER JOIN teams ON outcome_totals.outcome_holder_id = teams.id",
                :conditions => "seasons.publisher_id = #{publisher_id} AND
                               sub_seasons.sub_season_type = 'season-regular' AND
                               seasons.season_key = #{season_key} AND
                               standings.affiliation_id = #{affiliation_id} AND
                               overall_standing_subgroups.affiliation_id = #{sub_affiliation_id}",
                :order => "outcome_totals.rank + 0")
  
  end


  #############################################################################
  # Description:
  #   Get the playoff series for an affiliation
  #
  # Params:
  #   -affiliation_id - int - id of the affiliation to get playoffs series for
  #   -publisher_id - int - id of the publisher of the data
  #
  # Return:
  #
  #############################################################################
  def self.get_playoff_series(affiliation_id, round, time = TIME, publisher_id = PUBLISHER_ID)
    
    #get the season key
    season_key = get_season_key(affiliation_id, time)
    #get the season
    season = Season.find_by_season_key_and_league_id(season_key, affiliation_id)
    
    #get the conferences of the league
    conferences = Affiliation.get_conferences_by_league(affiliation_id)

    series = Array.new(conferences.size)
    
    conferences.size.times do |c|
     
      #get the number of teams in the conference that made playoffs
      num_teams = EventsSubSeason.find(
                        :all,
                        :select => "COUNT(DISTINCT(t1.participant_id)) AS num_teams",
                        :joins => "INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id
                         INNER JOIN events ON events.id = events_sub_seasons.event_id
                         INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
                         INNER JOIN team_phases ON team_phases.team_id = t1.participant_id AND team_phases.affiliation_id = #{conferences[c].affiliation_id}",
                        :conditions => "sub_seasons.season_id = #{season.id} AND sub_seasons.sub_season_type = 'post-season' AND events.playoff_round = #{round}"
      )

      #Get the top seeded teams and their opponent for the given round
      teams = EventsSubSeason.find(
                    :all,
                    :select => "MIN(events.start_date_time) AS min_time, t1.participant_id AS t1_id, t2.participant_id AS t2_id",
                    :joins => "INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id
                              INNER JOIN events ON events.id = events_sub_seasons.event_id
                              INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'
                              INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'
                              INNER JOIN team_phases ON team_phases.team_id = t1.participant_id AND team_phases.affiliation_id = #{conferences[c].affiliation_id}",
                    :conditions => "sub_seasons.season_id = #{season.id} AND sub_seasons.sub_season_type = 'post-season' AND events.playoff_round = #{round}",
                    :group => "t1.participant_id",
                    :order => "min_time",
                    :limit => (num_teams[0].num_teams.to_f/2.0).ceil
      )

      
      series[c] = Array.new([teams.size])
      
      teams.size.times do |t|
             
        series[c][t] = EventsSubSeason.find(
                        :all,
                        :select => "t1.participant_id AS t1_id,
                                    t1.alignment AS t1_alignment,
                                    t1.score AS t1_score,
                                    t1.event_outcome AS t1_outcome,
                                    t2.participant_id AS t2_id,
                                    t2.alignment AS t2_alignment,
                                    t2.score AS t2_score, 
                                    t2.event_outcome AS t2_outcome,
                                    events.id AS event_id,
                                    events.event_status,
                                    events.broadcast_listing,
                                    CONVERT_TZ(events.start_date_time, '+00:00', '#{TIMEZONE}') as start_date_time",
                        :joins => "INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id
                                  INNER JOIN events ON events.id = events_sub_seasons.event_id
                                  INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams'
                                  INNER JOIN participants_events AS t2 ON t2.event_id = events.id AND t2.participant_id <> t1.participant_id AND t2.participant_type = 'teams'",
                        :conditions => "sub_seasons.season_id = #{season.id}
                                        AND sub_seasons.sub_season_type = 'post-season'
                                        AND ((t1.participant_id = #{teams[t].t1_id} AND t2.participant_id = #{teams[t].t2_id} ) OR (t2.participant_id = #{teams[t].t2_id} AND t1.participant_id = #{teams[t].t1_id}))",
                        :order => "start_date_time"
        )

      
        series[c][t].each do |s|
          s.start_date_time = datetime_to_time(s.start_date_time)
        end
      
      end
      
      if num_teams[0].num_teams.to_i == 1
        series[c + 1] = nil
        break
      end
      
    end # close conferences loop
    
    return series.compact
    
  end

end
