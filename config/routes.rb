Rails.application.routes.draw do
  get 'dashboard', action: :index, controller: 'dashboard'

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

  resource :preferences, only: %i[edit update]

  root 'hello', action: :index, controller: 'hello'
end
