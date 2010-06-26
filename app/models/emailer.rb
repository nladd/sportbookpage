class Emailer < ActionMailer::Base


  #############################################################################
  # Description:
  #   Send an acceptance e-mail to the challengee for a newly created challenge
  #
  #############################################################################
  def accept_challenge(sender, recipient, challenge, event, taunt)

    @user = sender
    @recipient = recipient   
    @challenge = challenge
    @event = event
    @taunt = taunt  

    @favorite = Team.get_team(@challenge.favorite_id)
    
    @recipients = @recipient.email
    @from = "no-reply@sportbookpage.com"
    @subject = "Sportbookpage.com: " + @user.first_name + " " + @user.last_name + " has challenged you. Will you accept?"
    @sent_on = Time.now
    @content_type = "text/html"

  end

  
  #############################################################################
  # Description:
  #   Send an acceptance e-mail to the challengee for a modified challenge
  #
  ##########################################################################3##
  def modified_challenge(sender, recipient, old_challenge, challenge, note)
 
    @user = sender
    @recipient = recipient
    @old_challenge = old_challenge
    @challenge = challenge
    @note = note

    @recipients = @recipient.email
    @from = "no-reply@sportbookpage.com"
    @subject = "Sportbookpage.com: " + @user.first_name + " " + @user.last_name + " has modified your challenge. Will you accept?"
    @sent_on = Time.now
    @content_type = "text/html"

  end

 
  #############################################################################
  # Description:
  #   Send an e-mail rejecting a challenge
  #
  #############################################################################
  def reject_challenge(sender, recipient, challenge)
   
    @user = sender
    @recipient = recipient
    @challenge = challenge

    @recipients = @recipient.email
    @from = "no-reply@sportbookpage.com"
    @subject = "SportbookPage.com: " + @user.first_name + " " + @user.last_name + " has rejected your challenge"
    @sent_on = Time.now
    @content_type = "text/html"

  end
  
  
  #############################################################################
  # Description:
  #   Send an e-mail to invite a new user to join SportbookPage.com
  #
  #############################################################################
  def join_invitation(sender, recipient, message)
    
    @user = sender
    @message = message
    
    @recipients = recipient
    @from = "no-reply@sportbookpage.com"
    @subject = "SportbookPage.com: " + @user.first_name + " " + @user.last_name + " has invited you to join SportbookPage.com"
    @sent_on = Time.now
    @content_type = "text/html"
    
  end
  
  #############################################################################
  # Description:
  #   Send an e-mail reminder to a user that was invited to join sportbookpage.com
  #   but hasn't yet
  #
  #############################################################################
  def invitation_reminder(invitation)
    
    @user = User.find(invitation.inviter_id)
    
    @recipients = invitation.invitee_email
    @from = "no-reply@sportbookpage.com"
    @subject = "SportbookPage.com: You haven't accepted " + @user.first_name + "'s invitation to join SportbookPage.com"
    @sent_on = Time.now
    @content_type = "text/html"
    
  end
  
  
  #############################################################################
  # Description:
  #   Send an e-mail instructing a user their password has been reset
  #
  #############################################################################
  def password_reset(recipient, password)
    
    @user = recipient
    @password = password
    
    @recipients = recipient.email
    @from = "support@sportbookpage.com"
    @subject = "SportbookPage.com: Your password has been reset"
    @sent_on = Time.now
    @content_type = "text/html"
    
    
  end

end
