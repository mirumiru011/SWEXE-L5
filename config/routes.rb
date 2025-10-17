Rails.application.routes.draw do
  get "top/main"
  get "top/logout"
  
  get "top/login_form", as: 'top_login_form'
  post 'top/login', to: 'top#login', as: 'top_login' 

  root 'top#main'

  resources :users
  resources :tweets
  resources :likes, only: [:create, :destroy]
  resources :profiles, only: [:new, :create, :show, :edit, :update]
  get "up" => "rails/health#show", as: :rails_health_check

end
