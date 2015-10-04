class PagesController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!
  require 'json'
  TOTAL_IMAGES = 7
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
        _image_hash["url"] = p["image_url"]
        @images << _image_hash
      end
    end
    @image_slices = @images.each_slice(TOTAL_IMAGES).to_a
    @html_strings = {}
    _index = 0;
    @image_slices.each do |slice|
      _html_string = ""
      slice.each do |s|
        _html_string += "<div class='col-lg-3 col-lg-3 col-lg-4'><a 
        href='#'><img class='thumbnail img-responsive' src='#{s['url']}'></a></div>"
      end
      @html_strings[_index] = _html_string
      _index += 1
      @html_strings_json = @html_strings.to_json.to_s.gsub('/', '\/').html_safe
      
    end
  end

  def error
    redirect_to root_path if flash.empty?
  end
end
