Rails.application.routes.draw do
  devise_for :users
  resource :countries
end
