class LoginController < ApplicationController

  skip_before_filter :authorize

   def index
  
    if request.post?

      user = User.authenticate(params[:email], params[:password])
      
      if user != nil
        session[:user_id] = user.id
        redirect_to home_url
      else
        flash[:notice] = "Invalid username/password combination"
        redirect_to :action => "index"
      end
    end
  end


  def logout
    
    
  
  end

end
