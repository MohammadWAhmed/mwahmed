class PagesController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  require 'json'

  # Preview html email template
  def email
    tpl = (params[:layout] || 'hero').to_sym
    tpl = :hero unless [:email, :hero, :simple].include? tpl
    file = 'user_mailer/welcome_email'
    @user = (defined?(FactoryGirl) \
      ? User.new( FactoryGirl.attributes_for :user )
      : User.new( email: 'test@example.com', first_name: 'John', last_name: 'Smith' ))
    render file, layout: "emails/#{tpl}"
    if params[:premail] == 'true'
      puts "\n!!! USING PREMAILER !!!\n\n"
      pre = Premailer.new(response_body[0],  warn_level: Premailer::Warnings::SAFE, with_html_string: true)
      reset_response
      # pre.warnings
      render text: pre.to_inline_css, layout: false
    end
  end

  def home

    
  end

  def photography
    @images = []
    _query_500px = 'photos?feature=user&user_id=7856483&sort=rating&image_size=4&include_store=store_download&include_states=voted'
    _response = JSON.parse(F00px.get(_query_500px).body)
    _photos = _response["photos"]
    
    if !_photos.nil?
      _photos.each do |p|
        p_id = p["id"]
        _image_hash = {}
        _image_hash["name"] = p["name"]
        _image_hash["url"] = p["image_url"]
        _image_hash["width"] = p["width"]
        _image_hash["height"] = p["height"]
        _image_hash["viewed"] = p["times_viewed"]
        _image_hash["date"] = p["taken_at"] 
        _image_hash["500px_url"] = "http://500px.com" + p["url"]
        
        @images << _image_hash
      end
    end

  end

  def error
    redirect_to root_path if flash.empty?
  end
end
