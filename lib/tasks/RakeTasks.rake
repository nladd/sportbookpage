

task :send_invitation_reminder => :environment do

	one_week_ago = Time.now - 7*24*60*60
	one_week_ago = one_week_ago.strftime("%Y-%m-%d %H:%M:%S")

	invitations = Invitation.find_all_by_has_joined_and_reminder_sent(
			false,
			false,
			:conditions => "date_sent <= #{one_week_ago}")
			
	invitations.each do |invitation|
		Emailer.deliver_invitation_reminder(invitation)
		invitation.reminder_sent = true
		invitation.save
	end

end

