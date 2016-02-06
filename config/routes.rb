Rails.application.routes.draw do
  devise_for :users
  resource :countries
  get 'about' => 'static_pages#about'
  root 'static_pages#home'
end
