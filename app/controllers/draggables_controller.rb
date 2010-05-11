
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
 
    
    if (@dragged_id == "schedule" )
      load_schedule()
    elsif (@dragged_id == "friends")
      load_friends()
    elsif (@dragged_id == "profile")
      load_profile()
    elsif (@dragged_id == "roster")
      load_roster()
    elsif (@dragged_id == "standings")
      load_standings()
    elsif (@dragged_id == "scoreboard")
      load_scoreboard()
    elsif (@dragged_id == "playoffs")
        load_playoffs()
    elsif (@dragged_id == "challenges")
      load_challenges()
    elsif (@dragged_id == "headlines")
      load_headlines()
    elsif (@dragged_id == "lines")
      load_lines()
    elsif (@dragged_id == "leaders") 
      load_leaders()
    elsif (@dragged_id == "player_card")
      load_player_card()
    end
      
  end


  #############################################################################
  # Description:
  #   Load the variables needed to render a user's friends
  #
  #############################################################################
  def load_friends()
  
    template = choose_template
    @partial_path = 'draggables/home/' + template + 'fan_club'
  
    render(:update) { |page| 
                page.replace_html(@drop_id + "_title", "")
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", "")
    }
  
  end

  
  #############################################################################
  # Description:
  #   Load the variables needed to render a user's profile
  #
  #############################################################################
  def load_profile()
  
    @options = {"birthday" => "Birthday", 
           "hometown" => "Hometown",
           "about_me" => "More", 
           "favorite_coach" => "Favorite Coach", 
           "jersey_number" => "Jersey Number", 
           "favorite_team" => "Favorite Team", 
           "favorite_athlete" => "Favorite Player",  
           "favorite_sport" => "Sport"}

    user_id = @user.id
    path = RAILS_ROOT + "/public/users/#{user_id}/#{user_id}.profile"
    parser = XML::Parser.file(path)
    @profile = parser.parse
    @status = @profile.find_first("//root/status")
    
    template = choose_template
    @partial_path = "draggables/home/" + template + "profile"
    
    render(:update) { |page|
                page.replace_html(@drop_id + "_title", "")
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", "")
    }
  
  end


  #############################################################################
  # Description:
  #   Load the variables needed to render a team's roster
  #
  #############################################################################
  def load_roster( )
  
    @team = Team.get_team(session[:team_id])
    @roster = Team.get_roster(@team.team_id)  
  
    @drop_title = "#{@team.last_name} Roster"
    template = choose_template
    @partial_path = "draggables/" + @level + "/" + template + "roster"
  
    render(:update) { |page| 
              page.replace_html(@drop_id + "_title", @drop_title)
              page.replace_html(@drop_id, :partial => @partial_path)
              page.replace_html("#{@drop_id}_side_bar", "")
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render a leagues standings
  #
  #############################################################################
  def load_standings()
  
    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']
  
    if (@level == 'home')
      #get all the leagues availables
      @leagues = Affiliation.get_all_leagues()
      
      # remove leagues that are not in season
      @leagues.size.times do |i|
        if (!Affiliation.is_in_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
        end
      end
      #compact the leagues array to remove nil references
      @leagues = @leagues.compact
      
      # unless we want to see all leagues, remove the leagues that 
      # are not in the users profile
      if (@filter.blank?) then
        @leagues.size.times do |i|      
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
            @leagues[i] = nil
          end
        end
      end
      #compact the leagues array to remove nil references
      @leagues = @leagues.compact

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
      side_bar = "/draggables/partials/vertical_tabs"
    
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
      
      side_bar = "/draggables/partials/blank"
      @drop_title = "#{@league.abbreviation} Standings"
      
    end
    
    
    @partial_path = "draggables/" + @level + "/" + choose_template + "standings"
    
    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
    }
  
  end
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the schedule
  #
  #############################################################################
  def load_schedule()
  
    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']
  
    if (@level == 'home')
      @leagues = Affiliation.get_all_leagues()
      @games = Array.new(@leagues.size)

      @leagues.size.times do |i|
      
        if (!Affiliation.is_in_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
          next
        end
      
        if (@filter.blank?) then
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
            @leagues[i] = nil
            next
          end
        end
        
        @games[i] = Affiliation.get_next_n_games(
                                  @leagues[i].affiliation_id,
                                  96)
        
        if (@filter.blank?) then                          
          @games[i].size.times do |j|
            if( !(Team.team_is_in_profile(@leagues[i].affiliation_id, @games[i][j].t1_id, @user.id) ||
              Team.team_is_in_profile(@leagues[i].affiliation_id, @games[i][j].t2_id, @user.id)) ) then
              @games[i][j] = nil
            end
          end
        
          @games[i] = @games[i].compact
        end
        
      end
      
      # compact the leagues and games to remove nil references
      @leagues = @leagues.compact
      @games = @games.compact
      
      
      @drop_title = "Schedules"  
      side_bar = "draggables/partials/vertical_tabs"
      
    elsif (@level == 'league')
      @league = Affiliation.get_league(session[:league_id])
      @games = Affiliation.get_next_n_games(
                                  @league.affiliation_id, 
                                  200)
     
#      if (@filter.blank?) then                          
#        @games.size.times do |i|
#          if( !(Team.team_is_in_profile(@league.affiliation_id, @games[i].t1_id, @user.id) ||
#            Team.team_is_in_profile(@league.affiliation_id, @games[i].t2_id, @user.id)) ) then
#            @games[i] = nil
#          end
#        end
#      end
#     
#      @games = @games.compact
     
      @drop_title = "#{@league.abbreviation} Schedule"
      side_bar = "draggables/partials/blank"
            
    elsif (@level == 'team')
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id]) 
      
      @games = Team.get_next_n_games(@team.team_id, 200)
      
      side_bar = "draggables/partials/blank"
      @drop_title = "#{@team.last_name} Schedule"
      
    end
    
    @partial_path = '/draggables/' + @level + '/' + choose_template + 'schedule'
  
    render(:update) { |page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render scores from recently played games
  #
  #############################################################################
  def load_scoreboard()
    
    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']
    
    if (@level == 'home')
      @leagues = Affiliation.get_all_leagues()
      @games = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
      
        if (!Affiliation.is_in_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
          next
        end
       
        if (@filter.blank?) then
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
            @leagues[i] = nil
            next
          end
        end
      
        @games[i] = Affiliation.get_previous_n_games(@leagues[i].affiliation_id, 72)
        
        
        if (@filter.blank?) then                          
          @games[i].size.times do |j|
            if( !(Team.team_is_in_profile(@leagues[i].affiliation_id, @games[i][j].t1_id, @user.id) ||
              Team.team_is_in_profile(@leagues[i].affiliation_id, @games[i][j].t2_id, @user.id)) ) then
              @games[i][j] = nil
            end
          end
          @games[i] = @games[i].compact
        end      
        
      end
      
      # compact the leagues and games to remove nil references
      @leagues = @leagues.compact
      @games = @games.compact
      
      
      @drop_title = "Scoreboard"
      side_bar = "draggables/partials/vertical_tabs"
      
    elsif (@level == 'league')
      @league = Affiliation.get_league(session[:league_id])
      @games = Affiliation.get_previous_n_games(
                                  @league.affiliation_id, 
                                  144)                          
      
#      if (@filter.blank?) then                          
#        @games.size.times do |i|
#          if( !(Team.team_is_in_profile(@league.affiliation_id, @games[i].t1_id, @user.id) ||
#            Team.team_is_in_profile(@league.affiliation_id, @games[i].t2_id, @user.id)) ) then
#            @games[i] = nil
#          end
#        end
#        @games = @games.compact
#      end
                
      @drop_title = "#{@league.abbreviation} Scoreboard"
      side_bar = "draggables/partials/blank"
      
    elsif (@level == 'team')
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id])
      
      @games = Team.get_previous_n_games(@team.team_id, 200)
      
      side_bar = "draggables/partials/blank"
      @drop_title = "#{@team.last_name} Scoreboard"
      
    end


    @partial_path = "draggables/" + @level + "/" + choose_template + "scoreboard" 

    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
    }

  end

  #############################################################################
  # Description:
  #     Load the variables needed to render the playoffs partial
  #
  #############################################################################
  def load_playoffs()
  
    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']
  
    if (@level == "home")
        
      @leagues = Affiliation.get_all_leagues()
      @series = Array.new(@leagues.size)
      @conferences = Array.new(@leagues.size)
      @max_rounds = Array.new(@leagues.size)
      @rounds = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
      
        if (!Affiliation.is_in_post_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
          next
        end
       
        if (@filter.blank?) then
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
            @leagues[i] = nil
            next
          end
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
        
        
      end
      
      # compact the leagues and games to remove nil references
      @leagues = @leagues.compact
      @series = @series.compact
      @conferences = @conferences.compact
      @max_rounds = @max_rounds.compact
      @rounds = @rounds.compact
      
      
      side_bar = "draggables/partials/vertical_tabs"
            
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
            
    end
    
    @drop_title = "Playoffs"
    @partial_path = "draggables/" + @level + "/playoffs" 

    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
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

    @partial_path = "draggables/home/" + choose_template + "challenges"

    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", "")
    }

  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the headlines partial
  #
  #############################################################################
  def load_headlines()

    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']
  
    if (@level == 'home')
    
      @leagues = Affiliation.get_all_leagues()
      @leagues.size.times do |i|
      
        if (!Affiliation.is_in_season(@leagues[i].affiliation_id)) then
          @leagues[i] = nil
          next
        end
        
        if(@filter.blank?) then
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
              @leagues[i] = nil
          end
        end
      end
      
      @leagues = @leagues.compact
              
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
      
      side_bar = "draggables/partials/vertical_tabs"

    elsif (@level == 'league')
      
      @league = Affiliation.get_league(session[:league_id])
      
      @articles = Document.get_league_docs_by_fixture_key(
                                    @league.affiliation_id,
                                    "general-news",
                                    5)
      @titles = Array.new(@articles.size)
      @abstracts = Array.new(@articles.size)
      @dates = Array.new(@articles.size) 
      
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

    elsif (@level == 'team')
      @league = Affiliation.get_league(session[:league_id])
      @team = Team.get_team(session[:team_id])
      
      @articles = Document.get_team_docs_by_fixture_key(@team.team_id, "general-news", 5)
      
      @titles = Array.new(@articles.size)
      @abstracts = Array.new(@articles.size)
      @dates = Array.new(@articles.size) 
      
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
    
    @partial_path = "draggables/" + @level + "/headlines"

    render(:update) {|page| 
                page.replace_html(@drop_id + "_title", "")
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
    }
  
  end
  
  
  #############################################################################
  # Description:
  #   Load the variables needed to render the lines partial
  #
  #############################################################################
  def load_lines()

    side_bar = "/draggables/partials/blank"
    @filter = params['full_partial']

    if (@level == 'home')
      @leagues = Affiliation.get_all_leagues()
      @lines = Array.new(@leagues.size)
      
      @leagues.size.times do |i|
        
        if (!Affiliation.is_in_season(@leagues[i].affiliation_id) ) then
          @leagues[i] = nil
          next
        end
  
      
        if (@filter.blank?) then
          if ( !Affiliation.league_is_in_profile(@leagues[i].affiliation_id.to_i, @user.id) ) then
            @leagues[i] = nil
            next
          end
        end
      
        @lines[i] = Affiliation.get_lines(
                                  @leagues[i].affiliation_id,
                                  48)
                                  
        @lines[i].size.times do |j|
          if( !(Team.team_is_in_profile(@leagues[i].affiliation_id, @lines[i][j].t1_id, @user.id) ||
            Team.team_is_in_profile(@leagues[i].affiliation_id, @lines[i][j].t2_id, @user.id)) ) then
            @lines[i][j] = nil
          end
        end
      
        @lines[i] = @lines[i].compact
        
      end
      
      # compact the leagues and games to remove nil references
      @leagues = @leagues.compact
      @lines = @lines.compact

      @drop_title = "Lines"
      side_bar = "/draggables/partials/vertical_tabs"
      
    elsif (@level == 'league')
      @league = Affiliation.get_league(session[:league_id])
      @lines = Affiliation.get_lines(
                                  @league.affiliation_id, 
                                  48)                                  
    
#       @lines.size.times do |i|
#        if( !(Team.team_is_in_profile(@league.affiliation_id, @lines[i].t1_id, @user.id) ||
#          Team.team_is_in_profile(@league.affiliation_id, @lines[i].t2_id, @user.id)) ) then
#          @lines[i] = nil
#        end
#      end
      
#        @lines = @lines.compact
    
    
      @drop_title = "#{@league.abbreviation} Lines"
      side_bar = "/draggables/partials/blank"
      
    elsif (@level == 'team')
      @team = Team.get_team(session[:team_id]) 
      
      @drop_title = "#{@team.last_name} Lines"
      
    end
    
    
    @partial_path = '/draggables/' + @level + '/' + choose_template + 'lines'
    
    render(:update) { |page|
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html("#{@drop_id}_side_bar", :partial => side_bar)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.call('createGradient', @drop_id + "_frame")
                page.call("drawCurvyCorners")
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
    
    if (@stat_field = params["stat_field"]) == nil
      if sport_name == 'basketball' 
        @stat_field = "points_scored_per_game"
      elsif sport_name == 'ice hockey'
        @stat_field = "points"
      elsif sport_name == 'american football'
        @stat_field = "touchdowns_total"
      end
        
    end
    
    @league = Affiliation.get_league(session[:league_id])
      
    @stat = StatsMapping.find_by_stats_field_and_sport(@stat_field, sport_name)
    @stats_fields = StatsMapping.get_stats_fields(@stat.stats_type, sport_name, "AND stats_field <> '#{@stat_field}' AND priority = 1")

    @stats_mappings = StatsMapping.find_all_by_sport_and_priority(sport_name, 1)
  
    if(@level == 'league')
      @leaders = Affiliation.get_leaders(@league.affiliation_id, "points_scored_per_game")
    
      @drop_title = "#{@league.abbreviation} Leaders"
    
    elsif(@level == 'team')
      @team = Team.get_team(session[:team_id])
      @leaders = Team.get_leaders(@team.team_id, @stat_field)
    
      @drop_title = "#{@team.last_name} Leader"
    
    end
  
  
    template = choose_template
    @partial_path = '/draggables/' + @level + '/' + template + 'leaders'
  
    render(:update) { |page| 
                page.replace_html(@drop_id + "_title", @drop_title)
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", "")
    }
  
  
  end



  #############################################################################
  # Description:
  #   Load a player's card
  #
  #############################################################################
  def load_player_card
    @user = User.find(session[:user_id])
    
    @player = Person.get_card(session[:player_id])

    
    template = choose_template    
    @partial_path = '/draggables/' + @level + '/' + template + 'player_card'
  
    render(:update) { |page| 
                page.replace_html(@drop_id + "_title", "&nbsp;")
                page.replace_html(@drop_id, :partial => @partial_path)
                page.replace_html("#{@drop_id}_side_bar", "")
    }


  end


private

  def choose_template
  
     String ret = ""
  
     if (@drop_id == 'drop_2' || @drop_id == 'drop_3')
      ret = "tall_"
    end
    
    return ret

  end
  
  

end
