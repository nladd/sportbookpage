
require 'rubygems'
require 'xml/libxml'

class TeamController < ApplicationController

  layout :choose_layout

  def index

    @team = Team.get_team(params[:id])
    session[:team_id] = @team.entity_id
  
    @league = Team.get_league(@team.entity_id)
    session[:league_id] = @league.affiliation_id

    if (session[:visiting_id].blank?)
      @user = User.find(session[:user_id])
    else
      @user = User.find(session[:visiting_id])
    end

    session[:level] = "team"
    @level = "team"
    @drag_n_drop = "team/drag_n_drop"
    
    @drop_1 = "headlines"
    @drop_2 = "schedule"
    @drop_3 = "scoreboard"
    @drop_4 = "roster"

    user_path = ["Home", @league.abbreviation, @team.full_name]
    user_path_urls = ["/home", "/league/#{@league.entity_id}", "/team/#{@team.entity_id}"]
    @path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'

  end


end
