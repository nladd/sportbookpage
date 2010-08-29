class UnregisteredController < ApplicationController
  
  layout "unregistered"


  def index
    
    @user = User.find(session[:user_id])
    session[:visiting_id] = nil
    
    session[:level] = "home"
    @level = "home"
    @drag_n_drop = "home/drag_n_drop"
    

    @drop_1 = "headlines"
    session['drop_1'] = @drop_1
    
    @drop_2 = "schedule"
    session['drop_2'] = @drop_2
    
    @drop_3 = "scoreboard"
    session['drop_3'] = @drop_3
    
    @drop_4 = "standings"
    session['drop_4'] = @drop_4
        
    user_path = ["Home"] 
    user_path_urls = ["/home"] 
    @path_html = build_path(user_path, user_path_urls)
   
   
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
end
