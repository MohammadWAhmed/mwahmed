DisqusRails.setup do |config|
  config::SHORT_NAME = "mwahmed"
  config::PUBLIC_KEY = ENV['DISQUS_PUBLIC_KEY']
  config::ACCESS_TOKEN = ENV['DISQUS_TOKEN']
end