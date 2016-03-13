class MessageMailer < ActionMailer::Base

  default :from => 'noreply@mwahmed.com'

  def new_message(message)
    @message = message
    mail( :to => "wasiuddin.ahmed@hotmail.com",
    :subject => "MWAhmed contact from #{message.name}" )
  end

end