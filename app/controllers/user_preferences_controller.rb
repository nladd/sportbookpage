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
 
  layout :choose_layout
  skip_before_filter :authorize, :all

  #############################################################################
  # Description:
  #     Save a new user's account details entered on the previous form. The user
  #     may not proceed unless all required details were filled out. If a new user
  #     is successfully created, the user is directed to the profile info page
  #
  #############################################################################
  #def create_account
  #      
  #  save_successful = false
  #  match = false
  #  
  #  @user = User.find(session[:user_id])
  #  @user.errors.clear
  #  
  #  if request.post? then
  #    if params[:password] == params[:password_confirmation] then
  #      match = true
  #      save_successful = save_user
  #    else
  #      @user.errors.add(:password_confirmation, "Password and password confirmation did not match")
  #    end
  #  end
  #  
  #  #store the user's account details from the previous form  
  #  if (save_successful && match) then
  #    session[:user_id] = @user.id
  #    session[:user] = nil
  #    redirect_to home_url
  #  else
  #    session[:user] = @user
  #    respond_to do |format|
  #      format.html # create_account.html.erb
  #    end
  #  end
  #  
  #end

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
  #   Render the page for a user to edit their account information
  #
  #############################################################################
  def edit_account
  
    @user = User.find(session[:user_id])
  
    @show_password = false
    save_successful = false
    match = false

    @user.errors.clear
    
    if request.post? then
      if (params[:old_password] != "")

        if( User.encrypted_field(params[:old_password], @user.salt) != @user.hashed_password )
          logger.info "111111111"
          @user.errors.add(:old_password, "Old password was not valid")
          @show_password = true
        else
          if params[:password] == params[:password_confirmation] then
            logger.info "222222222"
            match = true
            save_successful = save_user(true)
          else
            logger.info "3333333"
            @user.errors.add(:password_confirmation, "Password and password confirmation did not match")
            @show_password = true
          end
          
        end
      else
        logger.info "44444444"
        match = true
        save_successful = save_user(false)
      end
      
      
      logger.info "save_successful = #{save_successful}"
      logger.info "match = #{match}"
      
      #store the user's account details from the previous form  
      if (save_successful && match) then
        flash[:notice] = "Account Information Saved!"
        @show_password = false
        @user = User.find(session[:user_id])
      else
        @show_password = true
        flash[:notice] = "Account Information Failed to Save"
      end      
      
    end


    # define the user path within the site
    user_path = ["Home", "Account Settings", "Edit Account"] 
    user_path_urls = ["/home", "javascript:void(0);", "/edit/account"] 
    @path_html = build_path(user_path, user_path_urls)
    
    respond_to do |format|
      format.html
    end
  end

  #############################################################################
  # Description:
  #   Save a user's profile information entered on the previous form. The user
  #   may not proceed unless all required fields were filled out. If the profile 
  #   creation is successful, the user is directed to the sports and teams pages
  #
  #############################################################################
  def create_profile
    
    begin    
      @user = User.find(session[:user_id])
    rescue 
      logger.error "Couldn't find user with id: " + session[:user_id].to_s
      return
    end
    
    @user.errors.clear
    save_successful = false #boolean indicator if the @user object was able to be persisted
    match = false   #boolean indicator if the password was correctly confirmed
    valid = false   #boolean indicator if hometown and sex were provided and birthdate is of age

    if request.post? then
    
      if params[:sex] != nil then
        @user.sex = params[:sex]
      else
        @user.errors.add(:sex, "Sex is a required field")
        valid = false
      end
  
      date = params[:date]
      #don't let newborn babies register
      if ((date[:year]).to_i >= (Time.now.year - 4))
        @user.errors.add(:birthday, "Children that are " + (Time.now.year- (date[:year]).to_i).to_s + " years old are not allowed to register")
      else
        @user.birthday = date[:month] + "/" + date[:day] + "/" + date[:year]
        valid = true
      end  
      
      profile = params[:profile]  
      if profile["hometown"] != "" then
        @user.hometown = profile["hometown"]
      else
        @user.errors.add(:hometown, "Hometown is a required field")
        valid = false
      end
      
      if params[:password] == params[:password_confirmation] then
        match = true
        save_successful = save_user(true)
      else
        @user.errors.add(:password_confirmation, "Password and password confirmation did not match")
      end

    end
    
    if valid && save_successful && match then
      #validation should have already been performed so this call is safe
      #@user.save
      write_profile(@user)
      check_invitations(@user)
      file = params[:photo]
      if !file.blank? then 
        save_profile_photo(file)
      else
        `cp #{RAILS_ROOT}/public/images/default_profile_image.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}.png`
        `cp #{RAILS_ROOT}/public/images/default_profile_image_thumbnail.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}_thumbnail.png`
        
      end
      session[:user] = nil
      session[:user_id] = @user.id
      redirect_to home_url
    else
      session[:user] = @user
      respond_to do |format|
        format.html # profile_info.html.erb
      end
    end
    
  end
  
  #############################################################################
  # Description:
  #   Render the page for a user to edit their profile information
  #
  #############################################################################
  def edit_profile
    session[:user] = nil

    begin    
      @user = User.find(session[:user_id])
    rescue 
      #TODO: Proper error handling
      logger.error "Couldn't find user with id: " + session[:user_id].to_s
      return
    end
     
    @user.errors.clear
    valid = false

    if request.post? then
      
      profile = params[:profile]  
      if profile["hometown"] != "" then
        @user.hometown = profile["hometown"]
        valid = true
      else
        @user.errors.add(:hometown, "Hometown is a required field")
      end

      if valid then
        #validation should have already been performed so this call is safe
        @user.save(false)
        write_profile(@user)
        file = params[:photo]
        if file != nil then 
          save_profile_photo(file)
        end
        
        session[:user_id] = @user.id
        flash[:notice] = "Profile information saved!"
      else
        flash[:notice] = "Profile Information Failed to Save"
      end  

    end    
    
     # load the current profile settings as the default value to display
    @currentValues = Hash.new
             
    path = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + ".profile"
    parser = XML::Parser.file(path)
    profile = parser.parse
    
    PROFILE_KEYS.each do |key|
      node = profile.find('//root/' + key)
      
      if !(node.blank?)
        @currentValues[key] = CGI.unescape(node[0].content)
        if (node[0]['show'] == 'yes')
          @currentValues['show_' + key] = true
        else
          @currentValues['show_' + key] = false
        end
        
      end
      
    end
    
    # define the user path within the site
    user_path = ["Home", "Account Settings", "Edit Profile"] 
    user_path_urls = ["/home", "javascript:void(0);", "/edit/profile"] 
    @path_html = build_path(user_path, user_path_urls)
    
    respond_to do |format|
      format.html # profile_info.html.erb
    end
    
  end
    
  
  #############################################################################
  # Description:
  #   Save a user's sports and teams selections
  #
  #############################################################################
  def create_sports_and_teams
    
    @user = User.new
    
    if request.post? then
      @user.save_without_validation!
      create_directories_and_files(@user)
      write_sports_and_teams(@user)
      session[:user] = @user
      session[:user_id] = @user.id
      redirect_to :action => "create_profile"
    else
      @pro_leagues = Affiliation.get_pro_leagues()
     
      @pro_teams = Array.new(@pro_leagues.size)
      @pro_leagues.size.times do |i|
        @pro_teams[i] = Affiliation.get_teams_by_league(@pro_leagues[i].affiliation_id, @pro_leagues[i].affiliation_key)
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
      
      
      respond_to do |format|
        format.html
      end
    end
    
  end
  
  #############################################################################
  # Description:
  #   Render the page for a user to edit their sports and teams selection.
  #
  #############################################################################
  def edit_sports_and_teams
  
    @user = User.find(session[:user_id])
  
    if request.post?
      write_sports_and_teams(@user)
      
      flash[:notice] = "Sports and teams selections saved!"
      
    end
    
    @pro_leagues = Affiliation.get_pro_leagues()
     
    @pro_teams = Array.new(@pro_leagues.size)
    @pro_leagues.size.times do |i|
      @pro_teams[i] = Affiliation.get_teams_by_league(@pro_leagues[i].affiliation_id, @pro_leagues[i].affiliation_key)
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
    user_path = ["Home", "Account Settings", "Edit Sports and Teams"] 
    user_path_urls = ["/home", "javascript:void(0);", "/edit/sports_and_teams"] 
    @path_html = build_path(user_path, user_path_urls)

 
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
  
    `cp #{RAILS_ROOT}/public/images/default_profile_image.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}.png`
    `cp #{RAILS_ROOT}/public/images/default_profile_image_thumbnail.png #{RAILS_ROOT}/public/users/#{@user.id}/#{@user.id}_thumbnail.png`
    
    # load the current profile settings as the default value to display
    @currentValues = Hash.new
             
    path = RAILS_ROOT + "/public/users/" + (@user.id).to_s + "/" + (@user.id).to_s + ".profile"
    parser = XML::Parser.file(path)
    profile = parser.parse
    
    PROFILE_KEYS.each do |key|
      node = profile.find('//root/' + key)
      
      if !(node.blank?)
        @currentValues[key] = CGI.unescape(node[0].content)
        if (node[0]['show'] == 'yes')
          @currentValues['show_' + key] = true
        else
          @currentValues['show_' + key] = false
        end
        
      end
      
    end
    
     # define the user path within the site
    user_path = ["Home", "Account Settings", "Edit Profile"] 
    user_path_urls = ["/home", "javascript:void(0);", "/edit/profile"] 
    @path_html = build_path(user_path, user_path_urls)
    
    render(:update) {|page| page.replace_html('photo_cell', "No photo<br/>uploaded" ) }
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
    
    profile_path = RAILS_ROOT + '/public/users/' + @user.id.to_s + '/' + @user.id.to_s + '.profile'

    parser = XML::Parser.file(profile_path)
    profile = parser.parse
    
    node = profile.find_first('//root/drop_1')
    node.content = session['drop_1']
    node = profile.find_first('//root/drop_2')
    node.content = session['drop_2']
    node = profile.find_first('//root/drop_3')
    node.content = session['drop_3']
    node = profile.find_first('//root/drop_4')
    node.content = session['drop_4']
  
    profile.save(profile_path)
    
    render(:update) {|page| 
      page.replace_html("message_banner", "Drag and Drop preferences saved!") 
      page.show("message_banner")
      page.visual_effect(:fade, "message_banner", :duration => 5)
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
    profile.root << drop_1_node = XML::Node.new('drop_1')
    drop_1_node << "profile"
    profile.root << drop_2_node = XML::Node.new('drop_2')
    drop_2_node << "headlines"
    profile.root << drop_3_node = XML::Node.new('drop_3')
    drop_3_node << "schedule"
    profile.root << drop_4_node = XML::Node.new('drop_4')
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
    #@user.question_2 = params[:question_2]
    #@user.answer_2 = params[:answer_2]
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
    `convert #{@real_file.path} -resize x120 #{dest_photo}&`
    `convert #{@real_file.path} -resize x50 #{dest_photo_t}&`
    
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
    user_id = (user.id).to_s
    profile_path = RAILS_ROOT + '/public/users/' + user_id + '/' + user_id + '.profile'

    parser = XML::Parser.file(profile_path)
    profile = parser.parse
    root = profile.root
    
    profile_hash = params[:profile]
    keys = profile_hash.keys
    
    show = params[:show]
    
    #write the xml for a user's profile 
    keys.each do |key| 
    
      # get the node if it previously exists
      node = profile.find('//root/' + key).first
    
      if node.blank?
        # the node didn't exist so create the node, then write the value
        root << node = XML::Node.new(key)
      end
      
      node.content = CGI.escape(profile_hash[key])
      
      # determine if the user has elected to the item in their profile
      if(show[key])
        logger.info "show[" + key + "] = " + show[key]
        node['show'] = 'yes'
      else
        node['show'] = 'no'
      end
      
    end
    
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
    profile_path = RAILS_ROOT + '/public/users/' + (user.id).to_s + '/' + (user.id).to_s + ".profile"
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
