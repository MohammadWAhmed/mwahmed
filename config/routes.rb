# Route prefixes use a single letter to allow for vanity urls of two or more characters
Rails.application.routes.draw do

  # Static pages
  get '/photography' => 'pages#photography', as: 'photography'
  get '/map' => 'pages#map', as: 'map'
  get '/contact' => 'pages#contact', as: 'contact'

  get 'robots.:format' => 'robots#index'
  get "sitemap.xml" => "sitemaps#index", :format => "xml", :as => :sitemap
  root 'pages#home'
end
