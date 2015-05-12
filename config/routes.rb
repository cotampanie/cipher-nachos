Rails.application.routes.draw do
  get 'log_out' => 'sessions#destroy', :as => :log_out
  get 'log_in' => 'sessions#new', :as => :log_in
  get 'sign_up' => 'users#new', :as => :sign_up

  resources :users do
    resources :movies
    resources :notifications
  end
  resources :sessions

  get 'movies/search' => 'movies#search', :as => :movies_search

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  get 'users/:user_id/movies' => 'movies#index', :as => :root

  get '/', to: 'main#index'
end
