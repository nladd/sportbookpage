class UnregisteredController < ApplicationController
  
  layout "unregistered"


  def index
    
    @user = User.find(1)
    session[:visiting_id] = nil
    
    session[:level] = "home"
    @level = "home"
    @drag_n_drop = "home/drag_n_drop"
    
    get_draggables(@user, @level)
    load_tagged_teams(@user)   
   
    user_path = ["Home"] 
    user_path_urls = ["/home"] 
    @path_html = build_path(user_path, user_path_urls)
   
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
end
