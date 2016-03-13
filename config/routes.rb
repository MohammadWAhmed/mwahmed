# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do

  # Static pages
  match '/projects/album_generator', to: 'projects#albums', via: :all
  get '/projects' => 'projects#index', as: 'projects'
  get '/photography' => 'pages#photography', as: 'photography'
  get '/map' => 'pages#map', as: 'map', via: :get
  get '/about' => 'pages#about', as: 'about'
  
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'

  get 'robots.:format' => 'robots#index'
  get "sitemap.xml" => "sitemaps#index", :format => "xml", :as => :sitemap
  root 'pages#home'
end
