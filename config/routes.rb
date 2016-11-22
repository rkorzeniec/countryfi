Rails.application.routes.draw do
  devise_for :users
  resources :countries, only: [:show]
  resources :checkins, except: [:show]
  resource :dashboard, only: [:show], controller: 'dashboard'

  get 'about' => 'static_pages#about'
  root 'static_pages#home'
end
