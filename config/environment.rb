# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Set ENV vars to defaults in application.yml
Rails.application.config.settings.env.each do |k, v|
  ENV[k] ||= (v.blank? ? '' : v.to_s)
end

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'mwahmed.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}