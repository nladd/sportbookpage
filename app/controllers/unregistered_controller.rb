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
   
    respond_to do |format|
      format.html # index.html.erb
    end
    
  end
  
end
