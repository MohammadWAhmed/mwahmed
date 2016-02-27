class VisiterNotifier < ApplicationMailer
	def send_admin_notification(details)
		@details = details
	    mail( :to => ENV['EMAIL'],
    	:subject => 'MWAhmed.com contact' )
	end
end