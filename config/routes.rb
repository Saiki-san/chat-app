Rails.application.routes.draw do
  devise_for :users
  # get 'messages/index'
  root to: "rooms#index"
  # ログイン・ユーザー情報の編集・ログアウトのアクション
  resources :users, only: [:edit, :update, :destroy]
  # チャットルームの作成アクション
  resources :rooms, only: [:new, :create]
end