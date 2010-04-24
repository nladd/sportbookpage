
require RAILS_ROOT + "/app/models/model_helpers.rb"

module ChallengeForm

  #############################################################################
  # Description:
  #   Load the state variables needed to initially display a challenge form. Then
  #   render the challenge_form partial
  #
  #############################################################################
  def load_challenge_form
    @challengee = User.find(params['challengee_id'])
      
    render(:update) { |page| page.replace_html('light_form', :partial => 'users/partials/challenge_form/challenge_form') }

  end

  #############################################################################
  # Description:
  #   Load the teams for the selected legue. Render the homt_team and away_team partials
  #
  #############################################################################
  def select_league
    
    @league_id = params['league']
    

    league = Affiliation.find_by_id(@league_id)
    @home_teams = Affiliation.get_teams_by_league(@league_id, league.affiliation_key, "display_names.last_name ASC")
    @away_teams = @home_teams
    
    render(:update) { |page| 
      page.replace_html('challenge_home_team', :partial => 'users/partials/challenge_form/home_team') 
      page.replace_html('challenge_away_team', :partial => 'users/partials/challenge_form/away_team') 
    }
      
  end
  
  
  #############################################################################
  # Description:
  #   Load the possible opponents for the selected home team. Render the away_team partial
  #
  #############################################################################
  def select_home_team
  
    @home_team_id = params['home_team']
    
    @away_teams = Team.get_schedule(
                          @home_team_id, 
                          nil, 
                          "DISTINCT(display_names.last_name), t2.participant_id AS entity_id",
                          "display_names.last_name ASC")
    
    
    
    render(:update) {|page|
      page.replace_html('challenge_away_team', :partial => 'users/partials/challenge_form/away_team')
    }
  
  end
  
  #############################################################################
  # Description:
  #   Load the possible dates for the selected home team and away team.
  #   Render the dates partial
  #
  #############################################################################
  def select_away_team
  
    @away_team_id = params['away_team']
    @home_team_id = params['home_team']
    
    @events = Event.get_game_dates(@home_team_id, @away_team_id)
    
    @events.each do |event|
      date = datetime_to_time(event.start_date_time)
      event.start_date_time = date.strftime("%D")
    end

    @teams = Event.get_event(@events[0].id)
        

    render(:update) {|page|
      page.replace_html('dates', :partial => 'users/partials/challenge_form/dates')
      page.replace_html('favorite', :partial => 'users/partials/challenge_form/favorite')
    }
  
  end
  
  #############################################################################
  # Description:
  #   Creates a new challenge by storing the challenge in the database and sending
  #   an acceptance e-mail to the challengee
  #
  #############################################################################
  def create_challenge

    @user = User.find(session[:user_id])

    challengee_id = params['challengee']['id']
    @challengee = User.find(challengee_id)

    event_id = params['event']['id']
    @event = Event.get_event(event_id)
    home_id = params['home_team']['id']
    away_id = params['away_team']['id']

    favorite_id = params['favorite_id']
    spread = params['spread']
    wager = params['wager']
    league_id = params['league']['id']
    @taunt = params['taunt']


    @challenge = Challenges.new
    @challenge.challengee_id = challengee_id
    @challenge.challenger_id = @user.id
    @challenge.event_id = event_id
    @challenge.favorite_id = favorite_id
    @challenge.spread = spread
    @challenge.wager = wager
    @challenge.start_date_time = @event.start_date_time
    @challenge.league_id = league_id

    @favorite = Team.get_team(favorite_id)
    if(home_id != favorite_id)
      @challenge.underdog_id = home_id
    else
      @challenge.underdog_id = away_id
    end


    begin
      @challenge.save
    rescue
      logger.info "Invalid challenge!"
      #TODO: error checking
    end

    Emailer.deliver_accept_challenge(@user, @challengee, @challenge, @event, @taunt)

    #update lightbox form with details of challenge
    render(:update) { |page| page.replace_html('light_form', :partial => 'users/partials/challenge_form/review_challenge') }
  end


  #############################################################################
  # Description:
  #   Accept a challenge and update the database
  #
  #############################################################################
  def accept_challenge
    
    @user = User.find(session[:user_id])

    challenge_id = params['challenge_id']
    challenge = Challenges.find(challenge_id.to_i)
    @drop_id = params['drop_id']    

    challenge.accepted = 'yes'
    challenge.save

    @challenges = Challenges.get_challenges(@user.id)

    if (@drop_id == 'drop_1' || @drop_id == 'drop_4')
      template = ""
    else
      template = "tall_"
    end

    partial_path = "draggables/" + template + "challenges"

    render(:update) { |page| page.replace_html(@drop_id, :partial => partial_path) }

  end


  #############################################################################
  # Description:
  #   Reject a challenge and update the database
  #
  #############################################################################
  def reject_challenge

    @user = User.find(session[:user_id])

    challenge_id = params['challenge_id'].to_i
    @challenge = Challenges.get_challenge(challenge_id)
    @challengee = User.find(@challenge.challenger_id)

    Challenges.delete(challenge_id)
    @drop_id = params['drop_id']

    @challenges = Challenges.get_challenges(@user.id)

    Emailer.deliver_reject_challenge(@user, @challengee, @challenge)

    if (@drop_id == 'drop_1' || @drop_id == 'drop_4')
      template = ""
    else
      template = "tall_"
    end

    partial_path = "draggables/" + template + "challenges"

    render(:update) { |page| page.replace_html(@drop_id, :partial => partial_path) }

  end


  #############################################################################
  # Description:
  #   Modify a challenge and update the database
  #
  #############################################################################
  def modify_challenge

    @user = User.find(session[:user_id])

    challenge_id = params['challenge_id']
    @challenge = Challenges.get_challenge(challenge_id.to_i)
    @drop_id = params['drop_id']

    @challenger = User.find(@challenge.challenger_id)

    render(:update) { |page| page.replace_html('light_form', :partial => 'users/partials/challenge_form/modify_challenge') }

  end

  
  #############################################################################
  # Description:
  #   Update the database with a modified challenge
  #
  #############################################################################
  def create_modified_challenge

    @user = User.find(session[:user_id])
 
    challenge_id = params['challenge']['id'].to_i
    @old_challenge = Challenges.get_challenge(challenge_id)
    mod_challenge = Challenges.find(challenge_id)
    mod_challenge.spread = params['spread'].to_i
    mod_challenge.wager = params['wager'].to_i
    mod_challenge.challengee_id = mod_challenge.challenger_id
    mod_challenge.challenger_id = @user.id
    @note = params['note']

    begin
      mod_challenge.save
    rescue
      #TODO: real error handling
      logger.info "Failed to save challenge!"
    end

    @challenge = Challenges.get_challenge(challenge_id)
    @challengee = User.find(@challenge.challengee_id)
    @challenges = Challenges.get_challenges(@user.id)

    Emailer.deliver_modified_challenge(@user, @challengee, @old_challenge, @challenge, @note)

    @drop_id = params['drop_id']
    if (@drop_id == 'drop_1' || @drop_id == 'drop_4')
      template = ""
    else
      template = "tall_"
    end

    partial_path = "draggables/" + template + "challenges"


    #update lightbox form with details of modified challenge
    render(:update) { |page| 
             page.replace_html('light_form', :partial => 'users/partials/challenge_form/review_modified_challenge') 
             page.replace_html(@drop_id, :partial => partial_path)
             }


  end

 
end
