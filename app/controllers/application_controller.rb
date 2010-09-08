# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'rubygems'
require 'xml/libxml'

class ApplicationController < ActionController::Base
  before_filter :authorize
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery :secret => 'ea77a9a240a8e3c65ae5ecfb7eb21103'
  
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

  
protected
    
  def authorize
    if session[:user_id] == 1
      return
    elsif User.find_by_id(session[:user_id]).blank?
      session[:user_id] = 1
      redirect_to :controller => "unregistered"
    end
  end
  
  def choose_layout
    return session[:user_id] == 1 ? "unregistered" : "users"
  end
  
    #############################################################################
  # Description:
  #   Load a current user's saved draggables preferences
  #
  #############################################################################
  def get_draggables(user, level)
    
    parser = XML::Parser.file(RAILS_ROOT + "/public/users/#{user.id}/#{user.id}.profile")
    profile = parser.parse
    node = profile.find_first("//root/#{level}/target01")
    @drop_1 = node.content
    session['drop_1'] = @drop_1
    node = profile.find_first("//root/#{level}/target02")
    @drop_2 = node.content
    session['drop_2'] = @drop_2
    node = profile.find_first("//root/#{level}/target03")
    @drop_3 = node.content
    session['drop_3'] = @drop_3
    node = profile.find_first("//root/#{level}/target04")
    @drop_4 = node.content
    session['drop_4'] = @drop_4
  end
  
  #############################################################################
  # Description:
  #   Load a user's tagged teams into the session hash
  #
  #############################################################################
  def load_tagged_teams(user)
    
    parser = XML::Parser.file(RAILS_ROOT + "/public/users/#{user.id}/#{user.id}.profile")
    profile = parser.parse
    
    pro_sports = profile.find('//root/proSports/sport')
    pro_sports = pro_sports.to_a
    college_sports = profile.find('//root/collegeSports/sport')
    college_sports = college_sports.to_a
    sports = pro_sports.concat(college_sports)
    
    tagged_teams = Hash.new
    sports.each do |sport|
      teams = sport.children
      ids = Array.new
	  teams.each do |team|
        ids.push(team['id'].to_i)
	  end
	  tagged_teams.store(sport['id'].to_i, ids)
	end

    session[:tagged_teams] = tagged_teams
  end
      
end
