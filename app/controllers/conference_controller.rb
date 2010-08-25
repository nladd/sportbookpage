class ConferenceController < ApplicationController

  layout :choose_layout

  def index
  
    @league = Affiliation.get_league(params[:league_id])
    session[:league_id] = @league.affiliation_id
    @conference = Affiliation.get_conference(params[:id])
    session[:conference_id] = @conference.affiliation_id
     

    if (session[:visiting_id].blank?)
      @user = User.find(session[:user_id])
    else
      @user = User.find(session[:visiting_id])
    end

    session[:level] = "league"
    @level = "league"
    @drag_n_drop = "league/drag_n_drop"
    
    @drop_1 = "schedule"
    @drop_2 = "scoreboard"
    @drop_3 = "standings"
    @drop_4 = "lines"

    user_path = ["Home", @league.abbreviation, @conference.full_name] 
    user_path_urls = ["/home", "/league/#{@league.affiliation_id}", "/league/#{@league.affiliation_id}/conference/#{@conference.affiliation_id}"] 
    @path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'
  
  end

private

  def choose_layout
    return session[:user_id] == 1 ? "unregistered" : "users"
  end

end
