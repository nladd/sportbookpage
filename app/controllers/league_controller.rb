class LeagueController < ApplicationController

  layout :choose_layout

  def index
  
    @league = Affiliation.get_league(params[:id])
    session[:league_id] = @league.affiliation_id

    if (session[:visiting_id].blank?)
      @user = User.find(session[:user_id])
    else
      @user = User.find(session[:visiting_id])
    end

    session[:level] = "league"
    @level = "league"
    @drag_n_drop = "league/drag_n_drop"
    
    get_draggables(@user, @level)

    user_path = ["Home", @league.abbreviation] 
    user_path_urls = ["/home", "/league/#{@league.entity_id}"] 
    @path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'
  
  end

end
