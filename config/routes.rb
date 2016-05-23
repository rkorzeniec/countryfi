Rails.application.routes.draw do
  devise_for :users
  resources :countries, only: [:index, :show]
  resources :checkins, except: :destroy
  get 'about' => 'static_pages#about'
  root 'static_pages#home'
end
