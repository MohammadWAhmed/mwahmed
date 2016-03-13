class MessageMailer < ActionMailer::Base

  default :from => 'noreply@mwahmed.com'

  def new_message(message)
    @message = message
    mail( :to => ENV['EMAIL'],
    :subject => "MWAhmed contact from #{message.name}" )
  end

end