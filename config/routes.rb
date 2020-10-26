Rails.application.routes.draw do
  devise_for :users
  # get 'messages/index'
  root to: "rooms#index"
  # ログイン・ユーザー情報の編集・ログアウトのアクション
  resources :users, only: [:edit, :update, :destroy]
  # チャットルームの作成画面遷移・チャットルーム作成・削除アクション
  resources :rooms, only: [:new, :create, :destroy] do
    # ネスト(入れ子)の関係。チャットルームに属しているメッセージという意味。
    # メッセージを投稿する際に、どのルームで投稿されたメッセージなのかをパスから判断できるようにする為、ネストを利用。
    # メッセージに結びつくルームのidの情報を含んだパスを、受け取れるようになる。
    resources :messages, only: [:index, :create]
  end
end