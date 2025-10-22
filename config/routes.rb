Rails.application.routes.draw do
  get "top/main"
  get "top/logout"
  
  get "top/login_form", as: 'top_login_form'
  post 'top/login', to: 'top#login', as: 'top_login' 

  root 'top#main'

  resources :users
  
  # 修正: likesをtweetsにネストさせ、いいね/いいね削除をツイートID経由で行う
  resources :tweets do
    # resource を単数形にしていることが重要
    resource :likes, only: [:create, :destroy] 
  end
  
  # 独立した resources :likes は削除
  # resources :likes, only: [:create, :destroy] # ← 削除

  resources :profiles, only: [:new, :create, :show, :edit, :update]
  get "up" => "rails/health#show", as: :rails_health_check

end
