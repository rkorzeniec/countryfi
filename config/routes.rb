# frozen_string_literal: true

Rails.application.routes.draw do
  post '/graphql', to: 'graphql#execute'

  namespace :profile do
    get '(:profile_name)', action: :show
    resource :availability, only: %i[show]
  end

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

  resources :notifications, only: :index do
    post :mark_as_read, on: :collection
    post :mark_as_read, on: :member
  end

  get 'about', to: 'about#index'
  get 'terms', to: 'terms#index'
  root to: 'hello#index'

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  get '/404', to: 'exceptions#index', code: '404'
  get '/422', to: 'exceptions#index', code: '422'
  get '/500', to: 'exceptions#index', code: '500'

  get 'shell', to: 'shell#index'

  namespace :admin do
    resources :users
    resources :border_countries
    resources :checkins
    resources :countries
    resources :announcements
    resources :notifications
    resources :country_alternative_spellings
    resources :country_calling_codes
    resources :country_languages
    resources :currencies
    resources :top_level_domains

    root to: 'users#index'
  end

  # TODO: remove after a while, because of the switch to profiles
  get 'dashboard', to: redirect('/profile')

  unless Rails.application.config.consider_all_requests_local
    get '*path', to: 'exceptions#index', code: '404'
  end
end
