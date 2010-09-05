

class PlayerController < ApplicationController

  layout 'users'

  def index
  
    @player = Person.get_player(params[:id])
    session[:person_id] = @player.person_id
  
    @team = Team.get_team(session[:team_id])
    session[:team_id] = @team.entity_id
  
    @league = Team.get_league(@team.entity_id)
    session[:league_id] = @league.affiliation_id

    if (session[:visiting_id].blank?)
      @user = User.find(session[:user_id])
    else
      @user = User.find(session[:visiting_id])
    end

    session[:level] = "person"
    @level = "person"
    @drag_n_drop = "person/drag_n_drop"
    
    get_draggables(@user, @level)

    user_path = ["Home", @league.abbreviation, @team.full_name, @player.full_name]
    user_path_urls = ["/home", "/league/#{@league.affiliation_id}", "/team/#{@team.team_id}", "/player/#{@player.person_id}"]
    @path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'
    
  end

end
