Rails.application.routes.draw do
  devise_for :users
  resources :checkins, except: :destroy
  resources :countries, only: [:show]
  get 'about' => 'static_pages#about'
  root 'static_pages#home'
end
