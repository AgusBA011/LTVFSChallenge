Rails.application.routes.draw do
  

  require 'resque/server'
  mount Resque::Server, at: '/admin/jobs'

  resources :short_urls do
  end

  #resources :short_urls, only: [:index, :create, :show]
  get "/" => "short_urls#index"
  get '*id' => 'short_urls#show'
  post '/' => 'short_urls#create'
end
