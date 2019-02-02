Rails.application.routes.draw do
  devise_for :users
  resources :countries, only: :show
  resources :checkins, except: %i[index show]
  namespace :checkins do
    resources :worlds, only: :index
    resources :europeans, only: :index
    resources :north_americans, only: :index
    resources :south_americans, only: :index
    resources :asians, only: :index
    resources :africans, only: :index
    resources :oceanians, only: :index
    resources :antarcticans, only: :index
  end
  get 'dashboard', action: :index, controller: 'dashboard'
  namespace :explore do
    resources :worlds, only: :index
    resources :europes, only: :index
    resources :north_americas, only: :index
    resources :south_americas, only: :index
    resources :asias, only: :index
    resources :africas, only: :index
    resources :oceanias, only: :index
    resources :antarcticas, only: :index
  end

  root 'home', action: :index, controller: 'home_page'

  unless Rails.application.config.consider_all_requests_local
    get '*path', to: 'exceptions#show', code: '404'
  end
end
