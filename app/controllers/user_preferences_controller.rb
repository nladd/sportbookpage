require 'rubygems'
require 'xml/libxml'
require 'fileutils' 
require 'digest/sha1'

###############################################################################
# Author:: Nathan Ladd
# 
# <b>Description:</b>
#
# This controller manages the views used to display the forms to edit a user's 
# preferences. This includes user account details, user player profile, and a 
# user's sports and teams.
#
###############################################################################

class UserPreferencesController < ApplicationController
 
  layout "users"
  skip_before_filter :authorize, :only => [:reset_password, :get_security_question, :verify_security_answer, :signup]


  #############################################################################
  # Description:
  #   Reset a user's password
  #
  #############################################################################
  def reset_password
    render :template => "login/reset_password"
  end
  
  
  #############################################################################
  # Description:
  #   Get a user's security question
  #
  #############################################################################
  def get_security_question
    
    user = nil
    
    if params[:email].blank?
      return
    else
      user = User.find_by_email(params[:email].downcase)
    end
        
    render(:update) { |page|
      if !user.blank?
        html = "Please answer your security question:<br/>#{user.question_1}"
        page.show 'answer_prompt', 'submit_answer'
        page.hide 'submit_email'
        page.call "$('email').disable"
      else
        html = "We're sorry, but the e-mail address, #{params[:email]}, is not registered with SportbookPage.com. Please try again"
      end
      
      page.replace_html('question', html)
      page.show 'question'
      
    }
    
  end
  
  
  #############################################################################
  # Description
  #   Verify the user answered his/her security question correctly
  #
  #############################################################################
  def verify_security_answer
    
    verified = false
    
    email = params[:email].downcase
      if !params[:answer].blank?
        answer = params[:answer].downcase
      else
        answer = ""
      end
      
      @user = User.find_by_email(email)
      
      if @user.answer_1 == answer
        
        #reset password and send email
        password = ActiveSupport::SecureRandom.base64(6)
        @user.password = password
        @user.save(false)
        
        Emailer.deliver_password_reset(@user, password)
        
        verified = true
      end
      
      render(:update) {|page|
        
        if verified
          page.replace_html 'answer_verified', "Your password has been reset. An e-mail was sent to #{email} with your new password. Follow in the instructions in the e-mail to login to SportbookPage.com with your new password."
          page.replace_html 'submit_answer', "<a href='/login'>Go to Login Page</a>"
        else
          page.replace_html 'answer_verified', "The provided answer does not match our records. Please try again. If you continue to have problems, please contact our support desk at <a href='mailto:support@sportbookpage.com'>support@sportbookpage.com</a>"
        end
        
        page.show 'answer_verified'
        
      }
  end
 
  
  #############################################################################
  # Description:
  #   Sign up a new user
  #
  #############################################################################
  def signup
    
    #if the session[:user_id] variable doesn't exist, then this is a user's first attempt to register,
    # so create a new user. If it does exist, then this user already tried to register and failed validation
    #so delete the previous User object that was created on the failed registreation
    if (!session[:user].blank?)
      session[:user].delete
    end
    
    @user = User.new
    
    #will be set to true if a user's profile saves successfully without validation errors
    @saved = false
  
    #if this is a post request, then the user wants to create a profile
    if request.post?
      
      #clear any errors so they don't show up as false positives
      @user.errors.clear

      if params[:password] == params[:password_confirmation] then
        @saved = save_user(true)
      else
        @saved = false
        #save the user anyway to show validation errors
        save_user(false)
        @user.errors.add(:password_confirmation, "Password and password confirmation did not match")
      end

    end
    
    if @saved
      #create the user directories and setup the basic files
      create_directories_and_files(@user)
      # copy over the default profile images
      `cp -f #{RAILS_ROOT}/public/images/default_profile_image.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}.png`
      `cp -f #{RAILS_ROOT}/public/images/default_profile_image_thumbnail.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}_thumbnail.png`
      #write the user's new profile
      write_profile(@user)
      flash[:notice] = "Profile settings saved!"
      
      session[:user_id] = @user.id
      session[:user] = nil
      redirect_to :action => "preferences"
    else
      session[:user] = @user
      flash[:notice] = "Registration errors!"
      redirect_to :login
    end
    
  end
  
  
  #############################################################################
  # Description:
  #   Render the page for a user to edit their account preferences
  #
  #############################################################################
  def preferences
    
    @user = User.find(session[:user_id])
      
    #will be set to false if a user's profile fails to save successfully due to validation errors
    @saved = true
  
    #if this is a post request, then the user wants to save their profile
    #if it's not a post request the user just wants to view their profile
    if request.post?
      write_sports_and_teams(@user)
      
      #clear any errors so they don't show up as false positives
      @user.errors.clear
 
      #if a password hasn't been entered don't save the password
      if (params[:password] == "********")
        @saved = save_user(false)
      else
        #if a password was entered verify that is matches the password confirmation
        if params[:password] == params[:password_confirmation] then
          @saved = save_user(true)
        else
          @saved = false
          @user.errors.add(:password_confirmation, "Password and password confirmation did not match")
          #save the user anyway so validation errors will show
          save_user(false)
        end
      end
      
      if @saved
        write_profile(@user)
        if params[:photo] != nil then
          save_profile_photo(params[:photo])
        end

        flash[:notice] = "Profile settings saved!"
      else
        flash[:notice] = "Unable to save profile"
      end  

    end    

        
    #get the professional leagues covered
    @pro_leagues = Affiliation.get_pro_leagues()
    
    #allocate new arrays to store the divisions and teams for each league
    @pro_divisions = Array.new(@pro_leagues.size)
    @pro_teams = Array.new(@pro_leagues.size)
    
    @pro_leagues.size.times do |i|
      #for each league, get the divisions of that league
      @pro_divisions[i] = Affiliation.get_divisions_by_league(@pro_leagues[i].affiliation_id)
      
      #allocate an array to store the teams of a division
      @pro_teams[i] = Array.new(@pro_divisions[i].size)
      
      @pro_divisions[i].size.times do |d|
        #for each division in a league, get the teams of that division
        @pro_teams[i][d] = Affiliation.get_teams_by_division(@pro_divisions[i][d].affiliation_id, @pro_leagues[i].affiliation_key)
      end
      
    end
    
    
    @college_leagues = Affiliation.get_college_leagues()
     
    @college_conferences = Array.new(@college_leagues.size)
    @college_teams = Array.new(@college_leagues.size)
    
    @college_conferences.size.times do |i|
      @college_conferences[i] = Affiliation.get_conferences_by_league(@college_leagues[i].affiliation_id)
      
      @college_teams[i] = Array.new(@college_conferences[i].size)
      
      @college_conferences[i].size.times do |j|
        
        @college_teams[i][j] = Affiliation.get_teams_by_conference(@college_conferences[i][j].affiliation_id, @college_leagues[i].affiliation_key)
      
      end
      
    end
    
    
    # define the user path within the site
    #user_path = ["Home", "Account Settings", "Edit Sports and Teams"] 
    #user_path_urls = ["/home", "javascript:void(0);", "/edit/sports_and_teams"] 
    #@path_html = build_path(user_path, user_path_urls)

    respond_to do |format|
      format.html #edit_sports_and_teams.html.erb
    end
    
  end
  
  
  #############################################################################
  # Description:
  #   Replace a user's profile photo and with the default photo
  #
  #############################################################################
  def delete_photo
    @user = User.find(session[:user_id])
  
    `cp -f #{RAILS_ROOT}/public/images/default_profile_image.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}.png`
    `cp -f #{RAILS_ROOT}/public/images/default_profile_image_thumbnail.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}_thumbnail.png`
    
    logger.info "<img src=\"/users/#{@user.id}/#{@user.id}.png\" alt=\"headshot\" name=\"headshot-none\" class=\"headshot\" />"
    
    render(:update) {|page|
      page.replace_html('photo_area', "<img src=\"/users/#{@user.id}/#{@user.id}.png\" alt=\"headshot\" name=\"headshot-none\" class=\"headshot\" />" )
      page.replace_html('left-column-photo', "<img src=\"/users/#{@user.id}/#{@user.id}_thumbnail.png\" alt=\"headshot\" name=\"headshot-none\" class=\"headshot\" />" )
    }
  end


  #############################################################################
  # Description:
  #   Save a user's updated status
  #
  #############################################################################
  def save_status
  
    @user = User.find(session[:user_id])
  
    @status = params[:status]
    
    path = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + ".profile"
    parser = XML::Parser.file(path)
    profile = parser.parse
    
    status_node = profile.find("//root/status")
    status_node[0].content = @status
    
    profile.save(path)
    
    render(:update) {|page| 
      page.replace_html('status_text', "<span style='font-weight: bold'>Status: </span>" + @status.to_s ) 
      page.replace_html('status_input', "<input id='status' maxLength='80' name='status' size='40' type='text' value='" + @status.to_s + "' />"  )
      

    }
    
  end
  
  
  #############################################################################
  # Description:
  #   Save a user's default drag and drop preferences
  #
  #############################################################################
  def save_drag_n_drop
    
    @user = User.find(session[:user_id])
    
    profile_path = RAILS_ROOT + "/public/users/#{@user.id}/#{@user.id}.profile"

    parser = XML::Parser.file(profile_path)
    profile = parser.parse
    
    # on a drop, the session variable get populated with the drop name
    node = profile.find_first('//root/target01')
    node.content = session['target01'].to_s
    node = profile.find_first('//root/target02')
    node.content = session['target02'].to_s
    node = profile.find_first('//root/target03')
    node.content = session['target03'].to_s
    node = profile.find_first('//root/target04')
    node.content = session['target04'].to_s
  
    profile.save(profile_path)
    
    render(:update) {|page|
      page.show("alert_text")
      page.replace_html("alert_text", "Drag and Drop preferences saved!")
      page.visual_effect(:fade, "alert_text", :duration => 10.0)
    }
  
  end
  
  
  
############################
# Start of private function declarations
############################  
private

  #############################################################################
  # Description:
  #   Choose the appropriate layout for the requested action
  #
  #############################################################################
  def choose_layout    
    if [ 'edit_account', 'edit_profile', 'edit_sports_and_teams' ].include? action_name
      'full_page'
    else
      'user_preferences'
    end
  end

  #############################################################################
  # Description:
  #     Create the necessary directories and files for a newly registered user
  #     Addtionally save the user's profile photo if they have uploaded one
  #
  # Params:
  #   -user - the User to create the dir and files for
  #
  # Return:
  # -nil
  #############################################################################
  def create_directories_and_files(user)
    user_id = (user.id).to_s
    dir_path = RAILS_ROOT + '/public/users/' + user_id
    xml_path = dir_path + '/' + user_id

    # create the users directory that will store the user's profile, chalkboard, and photo
    FileUtils.mkdir_p(dir_path)

    # create the chalkboard document
    chalkboard = XML::Document.new()
    chalkboard.root = XML::Node.new('root')
    chalkboard.save(xml_path + ".chalkboard")
  
    # create the profile document
    profile = XML::Document.new()
    profile.root = XML::Node.new('root')
    profile.root << drop_1_node = XML::Node.new('target01')
    drop_1_node << "profile"
    profile.root << drop_2_node = XML::Node.new('target02')
    drop_2_node << "headlines"
    profile.root << drop_3_node = XML::Node.new('target03')
    drop_3_node << "schedule"
    profile.root << drop_4_node = XML::Node.new('target04')
    drop_4_node << "scoreboard"
    profile.root << XML::Node.new('friends')
    profile.root << status_node = XML::Node.new('status')
    status_node << "New member"
    status_node['show'] = 'yes'
    profile.save(xml_path + ".profile")
    
  end
  
  ######################################
  # Description:
  #   Save a user's information into the database
  #
  # Return:
  #   -true if successful, false if not
  ######################################
  def save_user(save_password = true)
    @user.first_name = params[:first_name]
    @user.middle_name = params[:middle_name]
    @user.last_name = params[:last_name]
    @user.email = params[:email]
    @user.question_1 = params[:question_1]
    @user.answer_1 = params[:answer_1]
    @user.hometown = params[:hometown]
    @user.state = params[:state][:state]
    #@user.question_2 = params[:question_2]
    #@user.answer_2 = params[:answer_2]
    date = params[:date]
    @user.birthday = date[:month] + "/" + date[:day] + "/" + date[:year]
    @user.sex = params[:sex]
    if (save_password)
      @user.password = params[:password]
    else
      @user.password = @user.hashed_password
    end
      
    return @user.save
  end
  
  
  #############################################################################
  # Link an invitee and inviter to each other's fan clubs
  #
  #############################################################################
  def check_invitations(invitee)
       
    # check outstanding invitations for this new user
    invitations = Invitation.find_all_by_invitee_email_and_has_joined(invitee.email, false)
    invitations.each do |invite|
      
      invite.has_joined = true
      invite.save
      
      inviter = User.find(invite.inviter_id)
     
      path = RAILS_ROOT + "/public/users/#{invitee.id}/#{invitee.id}.profile"
      parser = XML::Parser.file(path)
      profile = parser.parse
      friends_node = (profile.find('//root/friends')).first
      friends = friends_node.children
  
      friends_node << new_friend_node = XML::Node.new('friend')
      new_friend_node['id'] = (inviter.id).to_s
      new_friend_node << inviter.first_name + " " + inviter.last_name
      
      profile.save(path)
      
      path = RAILS_ROOT + "/public/users/#{inviter.id}/#{inviter.id}.profile"
      parser = XML::Parser.file(path)
      profile = parser.parse
      friends_node = (profile.find('//root/friends')).first
      friends = friends_node.children
  
      friends_node << new_friend_node = XML::Node.new('friend')
      new_friend_node['id'] = (invitee.id).to_s
      new_friend_node << invitee.first_name + " " + invitee.last_name
      
      profile.save(path)
    
    end
    
    
  end
  
  #############################################################################
  # Description:
  #   Save a profile photo as well as a thumbnail if the user has specified a 
  #   photo to upload
  #
  # Params:
  #   -file - the uploaded file
  #
  # TODO: Handle errors if unable to create or save
  #############################################################################  
  def save_profile_photo(file)
    
    # @file should contain file uploaded by HTTP 
    # it is either StringIO object (if file was smaller than 10Kb)
    # or Tempfile (otherwise)
    if not (file.kind_of? StringIO or file.kind_of? Tempfile)
      return
    end
    
    # We can't use StringIO data to call external programs
    # So, if object is StringIO -- we have to create Tempfile
    if file.kind_of? StringIO
      # Yes, if file is StringIO, create new Tempfile and copy everything to it 
      @real_file = Tempfile.new("photo")
      while not file.eof? 
        @real_file.write file.read
      end
    else
      # Most uploads will be Tempfiles
      @real_file = file
    end
    
    # call to ImageMagick tool identity 
    identify = `identify -format %m,%w,%h #{@real_file.path} 2>&1`
    # Now identity is a string like "JPEG,640,480"
            
    # We split this string to array 
    @jpeg_info = identify.split(',', 3)
    # convert width and height to integer and assign it to object fields 
    width = @jpeg_info[1].to_i
    height = @jpeg_info[2].to_i      
    
    
    #if @jpeg_info == nil or @jpeg_info[0] != 'JPEG' or width <= 0 or height <= 0
    #   errors.add_to_base("Wrong image format (use only JPEG) or broken data")
    #   return
    #end
    
    dest_photo = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + ".png"
    dest_photo_t = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + "_thumbnail.png"

    # call imagemagick 'convert' utility
    `convert #{@real_file.path} -resize 95X95 #{dest_photo}&`
    `convert #{@real_file.path} -resize 47x47 #{dest_photo_t}&`
    
    FileUtils.chmod 0644, dest_photo
    FileUtils.chmod 0644, dest_photo_t
  end 

  #############################################################################
  # Description:
  #     Write the xml for a user's profile
  #
  # Params:
  #     -user - the user who's profile you're writing
  #
  # Return:
  # -nil
  ###############################################
  def write_profile(user)

    profile_path = RAILS_ROOT + "/public/users/#{user.id}/#{user.id}.profile"

    parser = XML::Parser.file(profile_path)
    profile = parser.parse
    root = profile.root
        
    show = params[:show]
    
    #for each node is a user's profile, if it doesn't exist, create it
    # then rewrite it's contents
    
    # get the birthday node if it exists
    node = profile.find('//root/birthday').first
    # the node didn't exist so create the node, then write the value
    root << node = XML::Node.new("birthday") if node.blank?
    #write the value
    node.content = CGI.escape(@user.birthday)
    # determine if the user has elected to not show the item in their profile
    logger.info "show = " + show['birthday'].to_s
    
    show['birthday'].blank? ? node['show'] = "yes" :  node['show'] = "no"
    
    # get the hometown node if it exists
    node = profile.find('//root/hometown').first
    # the node didn't exist so create the node, then write the value
    root << node = XML::Node.new("hometown") if node.blank?
    #write the value
    node.content = CGI.escape(@user.hometown + ", " + @user.state)
    # determine if the user has elected to the item in their profile
    show['hometown'].blank? ? node['show'] ="yes" : node['show'] = "no" 
    
    # get the sex node if it exists
    node = profile.find('//root/sex').first
    # the node didn't exist so create the node, then write the value
    root << node = XML::Node.new("sex") if node.blank?
    #write the value
    node.content = CGI.escape(@user.sex == "m" ? "Male" : "Female")
    # determine if the user has elected to the item in their profile
    show['sex'].blank? ? node['show'] = "yes" : node['show'] = "no"
          
    profile.save(profile_path)
  end
  
  #############################################################################
  # Description:
  #     Write the xml for a user's selected sports and teams
  #
  # Params:
  #     -user - the user who's sports and teams we're writing
  #
  # Return:
  # -nil
  ###############################################
  def write_sports_and_teams(user)
    profile_path = RAILS_ROOT + "/public/users/#{user.id}/#{user.id}.profile"
    parser = XML::Parser.file(profile_path)
    profile = parser.parse
    root = profile.root
  
    sports_node = profile.find('//root/sports').first
  
    if sports_node != nil
      
      #before nulling out a user's selected teams (they'll be added again later) decrement the team followers count
      xml_sports = profile.find('//root/sports/sport')
      xml_sports.each do |sport| 
        sport.each_element do |xml_team|
          team = Team.find(xml_team['id'])
          team.followers = team.followers - 1
          team.save
        end
      end
      xml_college_sports = profile.find('//root/sports/collegeSports/sport')
      xml_college_sports.each do |sport| 
        sport.each_element do |xml_team|
          team = Team.find(xml_team['id'])
          team.followers = team.followers - 1
          team.save
        end
      end
      
      sports_node.content = ""
    else
      root << sports_node = XML::Node.new('sports')
    end
            
    sports = params[:sports]
    # write the xml for a user's selected pro sports and teams. Pro sports and teams come in a name/id
    # pair from a post request. The name/id pair must be split prior to writing the node
    if !(sports.blank?) then
      sports = sports.sort
      sports.each do |sport|
        
        sport_name_id_pair = sport.split(',')
        sports_node << sport_node = XML::Node.new('sport')
        
        sport_node['sport'] = sport_name_id_pair[0].gsub(/[\s\.']/, "_")
        sport_node['sport_name'] = sport_name_id_pair[0]
        sport_node['id'] = sport_name_id_pair[1]
        
        teams = params[sport_node['sport']]        
        if !(teams.blank?) then
          teams = teams.sort
          teams.each do |team|
            team_name_id_pair = team.split(',')
            sport_node << team_node = XML::Node.new('team')
            team_node << team_name_id_pair[0]
            team_node["id"] = team_name_id_pair[1]
            
            #increment the team followers count
            db_team = Team.find(team_node["id"])
            db_team.followers = db_team.followers + 1
            db_team.save
          end
        end
        
      end
    end
    
    college_sports = params[:college]
    # write the xml for a user's selected college sports and teams. sports and teams come in a name/id
    # pair from a post request. The name/id pair must be split prior to writing the node
    if !(college_sports.blank?) then
      sports_node << college_sports_node = XML::Node.new('collegeSports')
      college_sports = college_sports.sort
      college_sports.each do |sport|
        
        sport_name_id_pair = sport.split(',')
        college_sports_node << sport_node = XML::Node.new('sport')
        
        sport_node['sport'] = sport_name_id_pair[0].gsub(/[\s\.']/, "_")
        sport_node['sport_name'] = sport_name_id_pair[0]
        sport_node['id'] = sport_name_id_pair[1]
        
        teams = params[sport_node['sport']]        
        if !(teams.blank?) then
          teams = teams.sort
          teams.each do |team|
            team_name_id_pair = team.split(',')
            sport_node << team_node = XML::Node.new('team')
            team_node << team_name_id_pair[0]
            team_node["id"] = team_name_id_pair[1]
            
            #increment the team followers count
            db_team = Team.find(team_node["id"])
            db_team.followers = db_team.followers + 1
            db_team.save
          end
        end
        
      end
    end

    profile.save(profile_path)
  end
  
 

end
