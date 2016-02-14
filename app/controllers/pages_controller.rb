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

  def about

  end

  def photography
    @images = getImages()
  end

  def map
    @images = getImages()

    # location is key 
    @img_with_loc = {}
    @images.each do |img| 
      if !img["lat"].nil? and !img["lng"].nil?
        @img_with_loc[[img["lat"].round(0), img["lng"].round(0)]].nil? ? 
        @img_with_loc[[img["lat"].round(0), img["lng"].round(0)]] = [[img["url"], img["title"]]]:
        @img_with_loc[[img["lat"].round(0), img["lng"].round(0)]] += [[img["url"], img["title"]]]
      end
    end
  end

  def getImages()
    images = []
    curr_page = 1
    query = queryBuilder(curr_page)
    total_pages = callF00px(images, query)
    curr_page += 1
    while(curr_page <= total_pages)
      query = queryBuilder(curr_page)
      total_pages = callF00px(images, query)
      curr_page += 1
    end
    return images
  end

  def queryBuilder(page)
    "photos?feature=user&user_id=7856483&sort=rating&image_size=4&include_store=store_download&include_states=voted&page=" + page.to_s
  end

  def callF00px(images, query)
    response = JSON.parse(F00px.get(query).body)
    photos = response["photos"]
    
    if !photos.nil?
      photos.each do |p|
        imageHash = {}
        imageHash["url"] = p["image_url"]
        imageHash["title"] = p["name"]
        imageHash["lat"] = p["latitude"]
        imageHash["lng"] = p["longitude"]
        images << imageHash
      end
    end
  
    return response["total_pages"]
  end

  def error
    redirect_to root_path if flash.empty?
  end

  private :getImages, :queryBuilder, :callF00px

end