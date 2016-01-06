class ProjectsController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  protect_from_forgery 
  require 'net/http'
  require 'uri'

	def index

	end

	def albums
		@url_text = params["urls"]
		@urls = !@url_text.nil? ? @url_text.split(",") : []
		#@bitly = Bitly.client.shorten(@x.to_s) if Rails.env.production?
		@bitly = nil
	end
  	
end