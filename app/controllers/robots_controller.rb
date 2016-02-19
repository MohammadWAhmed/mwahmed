# http://stackoverflow.com/questions/8215132/rails-dynamic-robots-txt-with-erb

class RobotsController < ApplicationController
  
  layout false

  # Render a robots.txt file based on whether the request is in production
  # and is performed against a canonical url or not.
  # Prevent robots from indexing content served via a CDN twice.
  def index
    respond_to :text
    expires_in 6.hours, public: true
  end

end
