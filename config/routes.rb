# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do

  # Static pages
  match '/projects/album_generator', to: 'projects#albums', via: :all
  get '/projects' => 'projects#index', as: 'projects'
  get '/photography' => 'pages#photography', as: 'photography'
  get '/map' => 'pages#map', as: 'map'
  get '/contact' => 'pages#contact', as: 'contact'
  get '/about' => 'pages#about', as: 'about'

  get 'robots.:format' => 'robots#index'
  get "sitemap.xml" => "sitemaps#index", :format => "xml", :as => :sitemap
  root 'pages#home'

  match '/contacts', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]

end
