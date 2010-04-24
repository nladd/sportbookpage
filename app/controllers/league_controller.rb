class LeagueController < ApplicationController

  layout "users"

  def index
  
    @league = Affiliation.get_league(params[:id])
    session[:league_id] = @league.affiliation_id
  
     4

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

    user_path = ["Home", @league.abbreviation] 
    user_path_urls = ["/home", "/league/#{@league.entity_id}"] 
    @path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'
  
  end


  

end
