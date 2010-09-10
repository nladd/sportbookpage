
require 'rubygems'
require 'xml/libxml'
require RAILS_ROOT + '/app/models/model_helpers.rb'


class DraggablesController < ApplicationController

  
  #############################################################################
  # Description:
  #   Route the request to the proper method
  #
  #############################################################################
  def route_action
    
    if (session[:visiting_id].blank?)
      @user = User.find(session[:user_id])
    else
      @user = User.find(session[:visiting_id])
    end
    

    @drop_id = params[:drop_id]
    @dragged_id = params[:dragged_id]
    session[@drop_id] = @dragged_id

    if (@level = session[:level]) == nil
      @level = 'home'
    end
 
    isCollege = false
    if ((@dragged_id =~ /college/) != nil)
      isCollege = true
    end
    
    logger.info "isCollege = " + isCollege.to_s
    
    if ((@dragged_id =~ /schedule/) != nil )
      load_schedule(isCollege)
    elsif (@dragged_id == "fanclub")
      load_fanclub()
    elsif (@dragged_id == "profile")
      load_profile()
    elsif (@dragged_id == "chalkboard")
      load_chalkboard()
    elsif (@dragged_id == "roster")
      load_roster()
    elsif (@dragged_id =~ /standings/) != nil
      load_standings(isCollege)
    elsif (@dragged_id =~ /scoreboard/) != nil
      load_scoreboard(isCollege)
    elsif (@dragged_id == "playoffs")
        load_playoffs()
    elsif (@dragged_id =~ /headlines/) != nil
      load_headlines(isCollege)
    elsif (@dragged_id =~ /lines/) != nil
      load_lines(isCollege)
    elsif (@dragged_id == "leaders")
      load_leaders()
    elsif (@dragged_id == "player_card")
      load_player_card()
    else
      return
    end
      
  end


  #############################################################################
  # Description:
  #   Load the variables needed to render a user's fanclub
  #
  #############################################################################
  def load_fanclub()
  
    xml_path = RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile"
    parser = XML::Parser.file(xml_path)
    profile = parser.parse
    friends_node = (profile.find('//root/friends')).first
    @friends = friends_node.children
  
    @partial_path = '/draggables/home/fanclub'
    @drop_title = 'Fanclub'
  
    render(:update) { |page| 
                page.replace_html(@drop_id, :partial => @partial_path)
    }
  
  end
  
  #############################################################################
  # Description:
  #   Load the variables needed to render a user's chalkboard
  #
  #############################################################################
  def load_chalkboard()

    @partial_path = '/draggables/home/chalkboard'
    @drop_title = 'Chalkboard'
  
    render(:update) { |page| 
                page.replace_html(@drop_id, :partial => @partial_path)
    }
  
  end


  
  #############################################################################
  # Description:
  #   Load the variables needed to render a user's profile
  #
  #############################################################################
  def load_profile()
    
    # Get the user's profile info if they've chosed to make it public
    @profile = Hash.new
    
    path = RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile"
    parser = XML::Parser.file(path)
    xml = parser.parse
    
    node = xml.find_first("//root/birthday")
    @profile.store("Birthday", CGI.unescape(node.content)) if node["show"].eql?("yes")
    node = xml.find_first("//root/hometown")
    @profile.store("Hometown", CGI.unescape(node.content)) if node["show"].eql?("yes")
    node = xml.find_first("//root/sex")
    @profile.store("Gender", CGI.unescape(node.content)) if node["show"].eql?("yes")
    node = xml.find_first("//root/status")
    @status = CGI.unescape(node.content.to_s)
    
    @partial_path = "/draggables/home/profile"
    @drop_title = "Profile"
    
    render(:update) { |page|
                page.replace_html(@drop_id, :partial => @partial_path)
    }
  
  end


  #############################################################################
  # Description:
  #   Load the variables needed to render a team's roster
  #
  #############################################################################
  def load_roster( )
  
    @team = Team.get_team(session[:team_id])
    @roster = Team.get_roster(@team.team_id, "display_names.last_name ASC")  
  
    @drop_title = "#{@team.last_name} Roster"
    
    @partial_path = "draggables/" + @level + "/roster"
  
    render(:update) { |page| 
              page.replace_html(@drop_id, :partial => @partial_path)
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render a leagues standings
  #
  #############################################################################
  def load_standings(isCollege)

    @filter = params['full_partial']
  
    if (@level == 'home')

      if isCollege
        @leagues = Affiliation.get_all_in_season_college_leagues(session[:tagged_teams].keys)
      else
        @leagues = Affiliation.get_all_in_season_pro_leagues(session[:tagged_teams].keys)
      end
      
      # create new arrays to hold the sub_affiliations for each league and 
      # the standings for each division
      @sub_affiliations = Array.new(@leagues.size)
      @standings = Array.new(@leagues.size)
      
      @leagues.size.times do |l|
      
          #get the type of standings we want to see division vs conference
          if (params['standings_type'] == 'conference') then
            @sub_affiliations[l] = Affiliation.get_conferences_by_league(
                                                    @leagues[l].affiliation_id)
            @sub_affiliation_type = 'Conference'
          else 
            @sub_affiliations[l] = Affiliation.get_divisions_by_league(
                                                    @leagues[l].affiliation_id)
            @sub_affiliation_type = 'Division'
          end  


        #create a sub-array to hold the standings for each division in the league
        @standings[l] = Array.new(@sub_affiliations[l].size)
        
        @sub_affiliations[l].size.times do |d|
          #for each division in the league, get the standings
          @standings[l][d] = Affiliation.get_standings(
                                                       @leagues[l].affiliation_id, 
                                                       @sub_affiliations[l][d].affiliation_id)

          if (params['full_partial'].blank?) then
            #variable to count if the user has any of the teams for a given division in their profile
            no_teams = 0
            @standings[l][d].size.times do |s|
              #for each team in a sub_affiliations standings determine if the team is not in the users profile
              if !(Team.team_is_in_profile(@leagues[l].affiliation_id, @standings[l][d][s].team_id, @user.id))
                #if the team is not in the users profile, increment this counter
                no_teams += 1
              end
            end
            
            # if the number of teams NOT in the user's profile is the same as 
            # the number of teams in the division, then none of the teams for that 
            # division are in the user's profile. Therefore, nil out that division 
            # and it's standings
            if(@standings[l][d].size == no_teams)
              @standings[l][d] = nil
              @sub_affiliations[l][d] = nil
            end
          end
                    
        end  
        #compact the arrays to remove nil references if no teams for the division were in the 
        #user's profile
        @standings[l] = @standings[l].compact
        @sub_affiliations[l] = @sub_affiliations[l].compact
  
        
  
      end
      
      @drop_title = "Standings"
    
    elsif (@level == 'league' || @level == 'team')
    
      @league = Affiliation.get_league(session[:league_id])
      #get the type of standings we want to see division vs conference
      if (params['standings_type'] == 'conference' || @league.affiliation_key =~ /ncaa/) then
        @sub_affiliations = Affiliation.get_conferences_by_league(
                                                @league.affiliation_id)
        @sub_affiliation_type = 'Conference'
      else 
        @sub_affiliations = Affiliation.get_divisions_by_league(
                                                      @league.affiliation_id)
        @sub_affiliation_type = 'Division'
      end  
      
      @standings = Array.new(@sub_affiliations.size)
      
      
      @sub_affiliations.size.times do |d|
        @standings[d] = Affiliation.get_standings(
                                            @league.affiliation_id, 
                                            @sub_affiliations[d].affiliation_id)
    
      end
      
      @drop_title = "#{@league.abbreviation} Standings"
      
    end
    
    
    @partial_path = "draggables/" + @level + "/standings"
   
    render(:update) {|page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }
  
  end
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the schedule
  #
  #############################################################################
  def load_schedule(isCollege)
  
    @filter = params['full_partial']
  
    if (@level.eql?("home"))
      
      if isCollege
        @leagues = Affiliation.get_all_in_season_college_leagues(session[:tagged_teams].keys)
      else
        @leagues = Affiliation.get_all_in_season_pro_leagues(session[:tagged_teams].keys)
      end
      
      @games = Array.new(@leagues.size)
      @leagues.size.times do |i|
        
        if (@filter.blank?) then
          @games[i] = Affiliation.get_next_n_games(
                                  @leagues[i].affiliation_id, 96,
                                  session[:tagged_teams][@leagues[i].affiliation_id.to_i])
        else
          @games[i] = Affiliation.get_next_n_games(
                                  @leagues[i].affiliation_id, 96)
        end
      end
      
      @drop_title = "Schedules"
      
    elsif (@level == 'league')
      @league = Affiliation.get_league(session[:league_id])
      @games = Affiliation.get_next_n_games(
                                  @league.affiliation_id,
                                  96)
     
      @drop_title = "#{@league.abbreviation} Schedule"
            
    elsif (@level == 'team' || @level.eql?("person"))
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id]) 
      
      @games = Team.get_next_n_games(@team.team_id, 200)
      
      @drop_title = "#{@team.last_name} Schedule"

    end
    
    @partial_path = "/draggables/#{@level}/schedule"

    render(:update) { |page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render scores from recently played games
  #
  #############################################################################
  def load_scoreboard(isCollege)

    @filter = params['full_partial']
    
    if (@level == 'home')
      
      if isCollege
        @leagues = Affiliation.get_all_in_season_college_leagues(session[:tagged_teams].keys)
      else
        @leagues = Affiliation.get_all_in_season_pro_leagues(session[:tagged_teams].keys)
      end
      
      @games = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
      
        if (@filter.blank?) then
          @games[i] = Affiliation.get_previous_n_games(
                                  @leagues[i].affiliation_id, 96,
                                  session[:tagged_teams][@leagues[i].affiliation_id.to_i])
        else
          @games[i] = Affiliation.get_previous_n_games(
                                  @leagues[i].affiliation_id, 96)
        end
        
      end

      @drop_title = "Scoreboard"
      
    elsif (@level == 'league')
      @leagues = Affiliation.get_league(session[:league_id])
      @games = Affiliation.get_previous_n_games(
                                  @league.affiliation_id, 
                                  96)                          
                
      @drop_title = "#{@league.abbreviation} Scoreboard"
      
    elsif (@level == 'team' || @level.eql?("person"))
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id])
      
      @games = Team.get_previous_n_games(@team.team_id, 200)
      
      @drop_title = "#{@team.last_name} Scoreboard"
      
    end


    @partial_path = "draggables/" + @level + "/scoreboard" 

    render(:update) {|page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }

  end

  #############################################################################
  # Description:
  #     Load the variables needed to render the playoffs partial
  #
  #############################################################################
  def load_playoffs()

    @filter = params['full_partial']
  
    if (@level == "home")
        
      #if (@filter.blank?) then
        @leagues = Affiliation.get_all_leagues(session[:tagged_teams].keys)
      #else
      #  @leagues = Affiliation.get_all_leagues
      #end
      
      @series = Array.new(@leagues.size)
      @conferences = Array.new(@leagues.size)
      @max_rounds = Array.new(@leagues.size)
      @rounds = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
      
        if (!Affiliation.is_in_post_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
          next
        end
        
        @conferences[i] = Affiliation.get_conferences_by_league(@leagues[i].affiliation_id)
        
        #get the season key
        season_key = get_season_key(@leagues[i].affiliation_id, TIME)
        #get the season
        season = Season.find_by_season_key_and_league_id(season_key, @leagues[i].affiliation_id)
        
        #get the most recent playoff round
        max_round = EventsSubSeason.find(:all,
                                    :select => "MAX(events.playoff_round) AS round",
                                    :joins => "INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id
                                                INNER JOIN events ON events.id = events_sub_seasons.event_id
                                                INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'",
                                    :conditions => "sub_seasons.season_id = #{season.id} AND sub_seasons.sub_season_type = 'post-season'")
        @max_rounds[i] = max_round[0].round.to_i
        
        if (!(params[:round].blank?) && (params[:league_id] == @leagues[i].affiliation_id))
            @rounds[i] = params[:round].to_i
        else
            @rounds[i] = @max_rounds[i]
        end
        
        
        @series[i] = Professional.get_playoff_series(@leagues[i].affiliation_id, @rounds[i])
        
        
        if (@series[i].size == 1)
            @conferences[i][0].full_name = "Finals"
            @conferences[i][1] = nil
            @conferences[i] = @conferences[i].compact
        end
        
      end
      
      # compact the leagues and games to remove nil references
      @leagues = @leagues.compact
      @series = @series.compact
      @conferences = @conferences.compact
      @max_rounds = @max_rounds.compact
      @rounds = @rounds.compact
      
      
    elsif (@level == "league")
        
        @league = Affiliation.get_league(session[:league_id])
        @conferences = Affiliation.get_conferences_by_league(@league.affiliation_id)
        
        #get the season key
        season_key = get_season_key(@league.affiliation_id, TIME)
        #get the season
        season = Season.find_by_season_key_and_league_id(season_key, @league.affiliation_id)
        
        #get the most recent playoff round
        max_round = EventsSubSeason.find(:all,
                                    :select => "MAX(events.playoff_round) AS round",
                                    :joins => "INNER JOIN sub_seasons ON sub_seasons.id = events_sub_seasons.sub_season_id
                                                INNER JOIN events ON events.id = events_sub_seasons.event_id
                                                INNER JOIN participants_events AS t1 ON t1.event_id = events.id AND t1.participant_type = 'teams' AND t1.alignment='home'",
                                    :conditions => "sub_seasons.season_id = #{season.id} AND sub_seasons.sub_season_type = 'post-season'")
        @max_round = max_round[0].round.to_i
        
        if (params[:round].blank?) 
            @round = @max_round
        else
            @round = params[:round].to_i
        end

        @series = Professional.get_playoff_series(@league.affiliation_id, @round)
        
        if (@series.size == 1)
            @conferences[0].full_name = "Finals"
            @conferences[1] = nil
            @conferences = @conferences.compact
        end
            
    end
    
    @drop_title = "Playoffs"
    @partial_path = "draggables/" + @level + "/playoffs" 

    render(:update) {|page| 
                page.replace_html(@drop_id, :partial => @partial_path)
    }
        
      
  end
  

  #############################################################################
  # Description:
  #   Load the variables needed to render the challenges partial
  #
  #############################################################################
  def load_challenges()
    
    @user = User.find(session[:user_id])
    

    @challenges = Challenges.get_challenges(@user.id)

    @drop_title = "Challenges"

    @partial_path = "draggables/home/challenges"

    render(:update) {|page| 
                page.replace_html(@drop_id, :partial => @partial_path)
    }

  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the headlines partial
  #
  #############################################################################
  def load_headlines(isCollege)

    @filter = params['full_partial']
  
    if (@level == 'home')
    
      if isCollege
        @leagues = Affiliation.get_all_in_season_college_leagues(session[:tagged_teams].keys)
      else
        @leagues = Affiliation.get_all_in_season_pro_leagues(session[:tagged_teams].keys)
      end
              
      @articles = Array.new(@leagues.size)
      @titles = Array.new(@leagues.size)
      @abstracts = Array.new(@leagues.size)
      @dates = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
        @articles[i] = Document.get_league_docs_by_fixture_key(
                                    @leagues[i].affiliation_id,
                                    "general-news",
                                    4)
        @titles[i] = Array.new(@articles[i].size)
        @abstracts[i] = Array.new(@articles[i].size)
        @dates[i] = Array.new(@articles[i].size) 
        
        @articles[i].size.times do |a|
          
          parser = XML::Parser.file(FEEDFETCHER_ARCHIVE + @articles[i][a].sportsml)
          article_xml = parser.parse
          @titles[i][a] = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1').content
          #author = article_xml.find_first('//sports-content/article/nitf/body/body.head/byline/person').content
          @abstracts[i][a] = article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract').content
          if @abstracts[i][a].length > 180
            @abstracts[i][a] = @abstracts[i][a][0, 180] + "..."
          end
          
          @dates[i][a] = datetime_to_time(@articles[i][a].date_time)
  
        end
                                    
      end

    elsif (@level == 'league')
      
      @league = Affiliation.get_league(session[:league_id])
      
      @articles = Document.get_league_docs_by_fixture_key(
                                    @league.affiliation_id,
                                    "general-news",
                                    5)
      @titles = Array.new(@articles.size)
      @abstracts = Array.new(@articles.size)
      @dates = Array.new(@articles.size) 


    elsif (@level == 'team')
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id])
      
      @articles = Document.get_team_docs_by_fixture_key(@team.team_id, "general-news", 5)
      
      @titles = Array.new(@articles.size)
      @abstracts = Array.new(@articles.size)
      @dates = Array.new(@articles.size) 

    elsif (@level.eql?("person"))
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id])
      
      @articles = Document.get_person_docs_by_fixture_key(@team.team_id, "general-news", 5)
      
      @titles = Array.new(@articles.size)
      @abstracts = Array.new(@articles.size)
      @dates = Array.new(@articles.size) 
      
    end
    
    if (@level.eql?("person") || @level.eql?("team") || @level.eql?("league"))
      @articles.size.times do |a|
          
          parser = XML::Parser.file(FEEDFETCHER_ARCHIVE + @articles[a].sportsml)
          article_xml = parser.parse
          @titles[a] = article_xml.find_first('//sports-content/article/nitf/body/body.head/hedline/hl1').content
          #author = article_xml.find_first('//sports-content/article/nitf/body/body.head/byline/person').content
          @abstracts[a] = article_xml.find_first('//sports-content/article/nitf/body/body.head/abstract').content
          if @abstracts[a].length > 200
            @abstracts[a] = @abstracts[a][0, 200] + "..."
          end
          @dates[a] = datetime_to_time(@articles[a].date_time)
          
      end
    end
    
    @partial_path = "draggables/#{@level}/headlines"
    @drop_title = "Headlines"

    render(:update) {|page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the lines partial
  #
  #############################################################################
  def load_lines(isCollege)

    @filter = params['full_partial']

    if (@level == 'home')
      
      if isCollege
        @leagues = Affiliation.get_all_in_season_college_leagues(session[:tagged_teams].keys)
      else
        @leagues = Affiliation.get_all_in_season_pro_leagues(session[:tagged_teams].keys)
      end
      
      @lines = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
              
        if (@filter.blank?) then
          @lines[i] = Affiliation.get_lines(
                                  @leagues[i].affiliation_id, 24,
                                  session[:tagged_teams][@leagues[i].affiliation_id.to_i])
        else
          @lines[i] = Affiliation.get_lines(
                                  @leagues[i].affiliation_id,
                                  24)
        end

      end

      @drop_title = "Lines"
      
    elsif (@level == 'league')
      @league = Affiliation.get_league(session[:league_id])
      @lines = Affiliation.get_lines(
                                  @league.affiliation_id, 
                                  48)                                  
    
      @drop_title = "#{@league.abbreviation} Lines"
      
    elsif (@level == 'team')
      @team = Team.get_team(session[:team_id]) 
      
      @drop_title = "#{@team.last_name} Lines"
      
    end
    
    
    @partial_path = "/draggables/#{@level}/lines"
    
    render(:update) { |page|
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }
  
  end


  #############################################################################
  # Description:
  #   Load the stat leaders
  #
  #############################################################################
  def load_leaders()
    @user = User.find(session[:user_id])
    

    @sport = Affiliation.get_sport_by_league_id(session[:league_id])
    sport_name = (@sport.full_name).downcase
    
    if (@stat_name = params["stat_name"]) == nil
      if sport_name == 'basketball' 
        @stat_name = "Points per game"
      elsif sport_name == 'ice hockey'
        @stat_name = "Points"
      elsif sport_name == 'american football'
        @stat_name = "Touchdowns"
      elsif sport_name == 'baseball'
        @stat_name = "Home Runs"
      end
        
    end
    
    @league = Affiliation.get_league(session[:league_id])
      
    @stat = StatsMapping.find_by_stats_name_and_sport(@stat_name, sport_name)
    @stats_fields = StatsMapping.get_stats_fields(@stat.stats_type, sport_name, "AND stats_name <> '#{@stat_name}' AND priority = 1")

    @stats_mappings = StatsMapping.find_all_by_sport_and_priority(sport_name, 1)
  
    if(@level == 'league')
      @leaders = Affiliation.get_leaders(@league.affiliation_id, @stat.stats_table, @stat.stats_field)
    
      @drop_title = "#{@league.abbreviation} League Leaders"
    
    elsif(@level == 'team')
      @team = Team.get_team(session[:team_id])
      @leaders = Team.get_leaders(@team.team_id, @stat_name)
    
      @drop_title = "#{@team.last_name} Team Leader"
    
    end
  
  
    @partial_path = "/draggables/#{@level}/leaders"
  
    render(:update) { |page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }
  
  
  end



  #############################################################################
  # Description:
  #   Load a player's card
  #
  #############################################################################
  def load_player_card
    @user = User.find(session[:user_id])
    
    @team = Team.get_team(session[:team_id])
    @league = Affiliation.get_league(session[:league_id])
    @sport = Affiliation.get_sport_by_league_id(@league.affiliation_id)
    @sport_name = (@sport.full_name).downcase
    
    @stats_types = StatsMapping.get_stats_types(@sport_name)
    
    @stats = Array.new(@stats_types.size)
    @fields = Array.new(@stats_types.size)

    @stats_types.size.times do |i|
      
      @fields[i] = StatsMapping.find_all_by_stats_type(@stats_types[i].stats_type)
      
      @stats[i] = Person.get_season_stats(session[:person_id], @stats_types[i].stats_type)
      
    end  

    
    @player = Person.get_card(session[:person_id])

    @partial_path = "/draggables/#{@level}/player_card"
  
    render(:update) { |page| 
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('expandCollapseCells', "#{@drop_id}")
    }


  end
 
  

end
