
  #############################################################################
  # Description:
  #   Converts a Ruby Time object to a sql-like DateTime string
  #
  # Params:
  #   -time - Time object to format
  #
  # Return:
  #   String - sql-like time
  #
  #############################################################################
  def time_to_datetime(time)
    # Add error checking for non-time type
    
    if !(time.is_a?(Time)) then
      return
    end
    
    
    
    return time.strftime("%Y-%m-%d %H:%M:%S")
  end
  
   #############################################################################
  # Description:
  #   Converts a sql-like DateTime string to a Ruby Time object 
  #
  # Params:
  #   -datetime - String - string in sql datetime format
  #   -tz - String - string of desired timezone in RFC 822 format
  #
  # Return:
  #   Time - Ruby Time object
  #
  #############################################################################
  def datetime_to_time(datetime)
    # Add error checking for non-time type
   
    if !(datetime.is_a?(String)) then
      return
    end

    return Time.parse(datetime)
  end
  
  
  #############################################################################
  # Description: 
  #   Get the season key for a given league
  #
  # Params:
  #   -league_id - int - the id of the league
  #   -time -Time - the time to get the most recent season key from
  #
  # Return:
  #   -season_key - the key of the latest season relative to time
  #
  #############################################################################
  def get_season_key(league_id, time)

    season_key = time.year
    season = nil
    while (season.blank?) 
      season = Season.find_by_season_key_and_league_id(season_key, league_id)
      if (season.blank?)
        season_key = season_key - 1
      end 
    end
  
    return season_key
  
  end
  
  


  

