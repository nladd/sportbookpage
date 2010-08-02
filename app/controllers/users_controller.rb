require 'rubygems'
require 'xml/libxml'
#require '/usr/lib/ruby/gems/1.8/gems/libxml-ruby-1.1.3/lib/xml/libxml'
require 'helpers/challenge_form_helper.rb'

class UsersController < ApplicationController
  
  include ChallengeForm
  
  layout :choose_layout

  #############################################################################
  # Description:
  #   Render the default home page for a user
  #
  #############################################################################
  def index
    
    @user = User.find(session[:user_id])
    session[:visiting_id] = nil
    
    session[:level] = "home"
    @level = "home"
    @drag_n_drop = "home/drag_n_drop"
    
    parser = XML::Parser.file(RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile")
    @profile = parser.parse
    drop_1_node = @profile.find_first('//root/drop_1')
    @drop_1 = drop_1_node.content
    session['drop_1'] = @drop_1
    drop_2_node = @profile.find_first('//root/drop_2')
    @drop_2 = drop_2_node.content
    session['drop_2'] = @drop_2
    drop_3_node = @profile.find_first('//root/drop_3')
    @drop_3 = drop_3_node.content
    session['drop_3'] = @drop_3
    drop_4_node = @profile.find_first('//root/drop_4')
    @drop_4 = drop_4_node.content
    session['drop_4'] = @drop_4
        
    user_path = ["Home"] 
    user_path_urls = ["/home"] 
    @path_html = build_path(user_path, user_path_urls)
   
   
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  #############################################################################
  # Description:
  #   Render the home page of a friend for viewing
  #
  #############################################################################
  def friend_home

    if ((session[:visiting_id].blank?))
      @user = User.find(params['friend_id'].to_i)
      session[:visiting_id] = @user.id
    else
      if (params['friend_id'].to_i != session[:visiting_id])
        @user = User.find(params['friend_id'].to_i)
        session[:visiting_id] = @user.id
      else
        @user = User.find(session[:visiting_id])
      end
    end
    
    parser = XML::Parser.file(RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile")
    @profile = parser.parse
    drop_1_node = @profile.find_first('//root/drop_1')
    @drop_1 = drop_1_node.content
    drop_2_node = @profile.find_first('//root/drop_2')
    @drop_2 = drop_2_node.content
    drop_3_node = @profile.find_first('//root/drop_3')
    @drop_3 = drop_3_node.content
    drop_4_node = @profile.find_first('//root/drop_4')
    @drop_4 = drop_4_node.content
    
    cgi_name = CGI.escape("#{@user.first_name} #{@user.last_name}")

    session[:level] = "home"
    @level = "home"
    @drag_n_drop = "home/drag_n_drop"
        
    user_path = [@user.first_name + " " + @user.last_name + " Home"] 
    user_path_urls = ["/fanatic/#{cgi_name}"] 
    @path_html = build_path(user_path, user_path_urls)

    render :template => "users/index"

  end


  #############################################################################
  # Description:
  #   Render the friends search page
  #
  #############################################################################
  def friends_search
      #when on the search page, we want to keep displaying the user's menus
      @user = User.find(session[:user_id])
      @results = nil
      
      
      if params['name'] != nil && params['name'] != '' then
      
        criteria = params['name']
        
        #create the regular expression used to search the database
        regexp = ".*"
        regexp = regexp + criteria.gsub(' ', '.*|.*')
        regexp = regexp + ".*"
        regexp = regexp.gsub('\\', '\\\\\\\\\\\\\\')
        begin 
          @results = User.find(
                      :all,
                      :select => "id, first_name, middle_name, last_name",
                      :conditions => "first_name RLIKE '#{regexp}' OR middle_name RLIKE '#{regexp}' OR last_name RLIKE '#{regexp}'",
                      :order => "(CASE WHEN last_name RLIKE '#{regexp}' THEN 'last_name' ELSE 0 END) + (CASE WHEN first_name RLIKE '#{regexp}' THEN 'first_name' ELSE 0 END) + (CASE WHEN middle_name RLIKE '#{regexp}' THEN 'middle_name' ELSE 0 END)")           

          if @results.empty? then
            @results = "NONE"
          end
        rescue
          logger.error "Error caught in controller => users_controller, action => friends_search"
          @results = nil
        end
        
      end
    
      user_path = ["Search"] 
      user_path_urls = ["/search"] 
      @path_html = build_path(user_path, user_path_urls)
    
      respond_to do |format|
        format.html #friend_search.html.erb
      end
  
  rescue
    #TODO: Error handling  
    logger.error "Error occurred! friends_controller.search()"
    
  end

  #############################################################################
  # Description:
  #   Add a friend to a user's profile. 
  #
  # Return:
  #   String indicating the result of the add
  #############################################################################
  def add_friend
  
    @user = User.find(session[:user_id])    
    @add_friend = User.find(params['friend_id'])
    
    @add_result = "Added"

    if !(@add_friend.blank?) then
      path = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + ".profile"
      parser = XML::Parser.file(path)
      profile = parser.parse
      friends_node = (profile.find('//root/friends')).first
      friends = friends_node.children

      friends.each do |friend|
        if (friend['id'] == (@add_friend.id).to_s) then
          @add_result = @add_friend.first_name + " is already one of your friends"
          break
        end
      end

      if (@add_result == "Added") then
        friends_node << new_friend_node = XML::Node.new('friend')
        new_friend_node['id'] = (@add_friend.id).to_s
        new_friend_node << @add_friend.first_name + " " + @add_friend.last_name
      
        profile.save(path)
      end
    
    end
  
    render(:update) { |page| page.replace_html('add_' + (@add_friend.id).to_s, @add_result) }
  
  end


  #############################################################################
  # Description:
  #   Load the form for a user to send an invitation to join sportbookpage.com
  #
  #############################################################################
  def invite_friend
    
    @user = User.find(session[:user_id])
    
    if request.post? && !params[:emails].blank?
      @emails = params[:emails]
      @emails = @emails.gsub(/\s/, "").split(",")
      message = params[:message]
      
      @emails.each do |email|
        Emailer.deliver_join_invitation(@user, email, message)
        invitation = Invitation.new
        invitation.invitee_email = email
        invitation.inviter_id = @user.id
        invitation.save
      end
      
      partial = "users/partials/invitation_sent"
    else
      partial = "users/partials/invitation_form"
    end
    
    render(:update) { |page| page.replace_html('pop-up', :partial => partial) }
  end
  
  
  #############################################################################
  # Description:
  #   Called when a comment is posted to a user's chalkboard. Writes the comment
  #   to user_id.profile and renders the partial which will display the comment in
  #   the chalkboard
  #
  #############################################################################
  def submit_comment
    #don't accept blank comments
    if (params[:comment] == "" )
      return
    end
  
    if !session[:visiting_id].blank?
      @user = User.find(session[:visiting_id])
      @author = User.find(session[:user_id])
      
      write_comment_xml(@author, @user.id)
      
      render(:update) { |page| page.replace_html('chalkboard', :partial => 'users/partials/chalk_board') }
 
    end
    
    
  end
  

###################################
##############################
#
# Private functions declarations go below this line
#
##############################
###################################  
private
  
  #############################################################################
  # Description:
  #   Choose the appropriate layout for the requested action
  #
  #############################################################################
  def choose_layout    
    if ['friends_search'].include? action_name
      'full_page'
    else
      'users'
    end
  end
  
 
  #############################################################################
  # Description:
  #     Write the xml for a comment posted to a user's chalkboard
  #
  # Params:
  #     -submitter - the User that submitted the comment
  #     -owner_id  - the id of owner of the chalkboard that a comment is being
  #                  written to
  #
  #############################################################################
  def write_comment_xml(submitter, owner_id)
  
    @submit_comment = CGI.escape(params[:comment])
    time = Time.now
    
    # convert time to 12hr am/pm
    hour = ( time.hour % 12 == 0 ? "12" : (time.hour % 12).to_s )
    minute = ( time.min < 10 ? "0" + (time.min).to_s : (time.min).to_s )
    
    #path of file to write
    path = RAILS_ROOT + "/public/users/" + owner_id.to_s + "/" + owner_id.to_s + ".chalkboard"

    chalkboard = XML::Document.file(path)   
    chalkboard.root << new_comment = XML::Node.new('comment')

    new_comment << from_node = XML::Node.new('from')
    from_node << submitter.first_name + " " + submitter.last_name
    from_node['id'] = submitter.id
    new_comment << time_node = XML::Node.new('time')
    time_node << hour.to_s + ":" + minute + ( time.hour < 12 ? "am" : "pm" )
    new_comment << date_node = XML::Node.new('date')
    date_node << time.month.to_s + "/" + time.day.to_s + "/" + time.year.to_s
    new_comment << text_node = XML::Node.new('text')
    text_node << @submit_comment
   
    if chalkboard.save(path, :indent => true, :encode => 'UTF-8')
      return 1
    else
      return 0
    end
    
  end
  
  
end
