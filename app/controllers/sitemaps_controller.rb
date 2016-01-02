class SitemapsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  def index
    @static_pages = [root_url]

    respond_to do |format|
      format.xml
    end
  end
end
