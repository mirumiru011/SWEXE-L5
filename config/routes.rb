Rails.application.routes.draw do
  
  # トップページの設定（最初に処理されるべき）
  root 'top#main'
  
  # TopControllerのアクション
  # ログインフォームの表示（不要だが残す場合はGET）
  get "top/main" 
  
  # ログイン処理: フォームからの送信を受けるため POST
  post 'top/login', as: 'top_login' 
  
  # ログアウト処理: セッション破棄のため GET（または DELETE）
  get "top/logout" 
  
  # RESTfulリソース (CRUD機能に必要なルーティングを自動生成)
  resources :users
  resources :tweets

  # いいね機能: 作成(POST)と削除(DELETE)のみに限定
  resources :likes, only: [:create, :destroy]

  # --- ここから下のRails自動生成部分はそのまま残します ---
  get "up" => "rails/health#show", as: :rails_health_check
end
