# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  before_filter :authorize
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => 'ea77a9a240a8e3c65ae5ecfb7eb21103'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
  
  ##############################################################################
  #  Description:
  #   Creates the string that display's the user's path location within the site
  #
  # Params:
  #     -paths - Array - Location of the user within the site as an array. Each element of the array
  #                       should be a string representing the next level as will be displayed on screen
  #     =path_urls - Array - an array of urls to map to each display_loc
  #############################################################################
  def build_path(paths, path_urls)
    html = ""
    
    if(paths.length != path_urls.length)
      html = "<a href='/home'>Home</a>"
    else
      paths.length.times do |i|
        html = html + "<a href='" + path_urls[i].to_s + "'>" + paths[i].to_s + "</a>";
     
        if( i + 1 < paths.length ) 
          html = html + " > ";
        end
      
      end
    end
    
    return html
    
  end
  
  
  #############################################################################
  # Description:
  #   Create the html for a draggable element
  #
  # Params:
  #   -element_id - string - the id the created element should have
  #
  #############################################################################
  def create_draggable_element(element_id)
  
    html = "<div class='drop_item' id='#{element_id}'>"
    html = html + "<div id='#{element}_title'>"
    html = html + "<h1>Scoreboard</h1></div></div>"
    
    return html
  
  end
  
  
protected
    
  def authorize
    unless User.find_by_id(session[:user_id])
      flash[:notice] = "Please log in"
      redirect_to :controller => 'login'
    end
  end
    
end
