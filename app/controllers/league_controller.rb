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
    
    parser = XML::Parser.file(RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile")
    @profile = parser.parse
    drop_1_node = @profile.find_first("//root/#{@level}/target01")
    @drop_1 = drop_1_node.content
    session['drop_1'] = @drop_1
    drop_2_node = @profile.find_first("//root/#{@level}/target02")
    @drop_2 = drop_2_node.content
    session['drop_2'] = @drop_2
    drop_3_node = @profile.find_first("//root/#{@level}/target03")
    @drop_3 = drop_3_node.content
    session['drop_3'] = @drop_3
    drop_4_node = @profile.find_first("//root/#{@level}/target04")
    @drop_4 = drop_4_node.content
    session['drop_4'] = @drop_4

    #user_path = ["Home", @league.abbreviation] 
    #user_path_urls = ["/home", "/league/#{@league.entity_id}"] 
    #@path_html = build_path(user_path, user_path_urls)
 
    render :template => 'users/index'
  
  end

end
