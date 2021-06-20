# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'hello#index'
  # FIXME: once webpacker is able to support service workers
  get '/service-worker.js', to: 'service_worker#service_worker'
  get '/manifest.json', to: 'service_worker#manifest'

  post '/graphql', to: 'graphql#execute'

  devise_for :users

  authenticated :user do
    root to: 'profile#show', as: :root_app

    namespace :profile do
      get '(:profile_name)', action: :show
    end

    namespace :profiles do
      resource :availability, only: %i[show]
    end

    resources :checkins
    resources :explores, only: :index
    resource :preferences, only: %i[edit update]

    resources :notifications, only: :index do
      post :mark_as_read, on: :collection
      post :mark_as_read, on: :member
    end

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
  end

  resources :countries, only: :show

  get 'about', to: 'about#index'
  get 'terms', to: 'terms#index'

  get 'shell', to: 'shell#index'
  get 'offline', to: 'offline#index'

  get '/404', to: 'exceptions#index', code: '404'
  get '/422', to: 'exceptions#index', code: '422'
  get '/500', to: 'exceptions#index', code: '500'

  # TODO: remove after a while, because of the switch to profiles
  get 'dashboard', to: redirect('/profile')

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql'
  end

  unless Rails.application.config.consider_all_requests_local
    get '*path', to: 'exceptions#index', code: '404'
  end
end
