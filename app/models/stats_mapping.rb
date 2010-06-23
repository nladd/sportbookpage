class StatsMapping < ActiveRecord::Base


  ############################################################################
  # Description:
  #   Get the stat tables associated with a given stat_type and sport
  #
  # Params:
  #   -stats_type - type or stat to get, 
  #                 e.g. "basketball_offensive_stats|baseball_pitching_stats"
  #   -sport - sport the stat belongs to
  #   -conditions - SQL formatted conditions to filter resutls (used for priority levels)
  #                 this parameter must be prefeixed by 'AND'
  #                 Note: This is an optional parameter that defaults to "AND priority = 1"
  #
  # Return:
  #   :select => "DISTINCT(stats_table)"
  #############################################################################
  def self.get_stats_tables(stats_type, sport, conditions = "AND priority = 1")
  
    return StatsMapping.find_all_by_stats_type(
                    stats_type,
                    :select => "DISTINCT(stats_table)",
                    :conditions => "sport = '#{sport}'")
  
  end

  
  #############################################################################
  # Description:
  #   Get all stats_fields associated with a given stat_type and sport
  #
  # Params:
  #   -stats_type - type or stat to get, 
  #                 e.g. "basketball_offensive_stats|baseball_pitching_stats"
  #   -sport - sport the stat belongs to
  #
  # Return:
  #   - stats_mappings.*
  #############################################################################
  def self.get_stats_fields(stats_type, sport, conditions = "AND priority = 1")
  
    return StatsMapping.find_all_by_stats_type(
                stats_type,
                :conditions => "sport = '#{sport}'",
                :order => "stats_name ASC")
  
  end
  
  
  #############################################################################
  # Description:
  #   Get all stats_fields associated with a given stat_type and sport
  #
  # Params:
  #   -stats_type - type or stat to get, 
  #                 e.g. "basketball_offensive_stats|baseball_pitching_stats"
  #   -sport - sport the stat belongs to
  #
  # Return:
  #   - :select => "DISTINCT(stats_type) as stats_type
  #############################################################################
  def self.get_stats_types(sport)
    
    return StatsMapping.find_all_by_sport(
                              sport,
                              :select => "DISTINCT(stats_type) as stats_type",
                              :order => "stats_type")
    
    
  end


end
