class LoginController < ApplicationController

  skip_before_filter :authorize

   def index
  
    # the session[:user] variable will be populated by the user_preferences.signup() method
    # if new user registration failed
    if session[:user].blank?
      @user = User.new
    else
      @user = session[:user]
    end
  
    if request.post?

      user = User.authenticate(params[:email], params[:password])
      
      if user != nil
        session[:user_id] = user.id
        redirect_to home_url
      else
        flash[:notice] = "Invalid username/password combination"
        redirect_to :back
      end
    end
  end


  def logout
    
    reset_session
    flash[:notice] = "Logout successful!"
    
    redirect_to :login
  
  end
  

end
