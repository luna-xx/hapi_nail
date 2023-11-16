Rails.application.routes.draw do
#"表示URL"=>"controller#action" で表示ページを記載
# ユーザー関連のルーティング
  devise_for :users
  
  devise_scope :user do
    # get  '/users', to: redirect("/users/sign_up")
    # ゲストユーザーログイン
    post 'users/guest_sign_in', to: "customer/sessions#guest_sign_in"
  end
  
  # 会員ホーム
  root to: 'customer/homes#top'
  
  # 会員ページ
  scope module: :customer do
    resources :users, only: [:index, :edit, :update, :create]
    get   'user/my_page'  => "users#show"
    get   'user/quit'     => "users#quit"
    patch 'user/withdraw' => "users#withdraw"
  
  # タグ関連
    get 'tag/index'  => "tags#index"
    get 'search_tag' => "posts#search_tag" # タグ検索
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource  :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get   'posts/:id/edit' => 'posts#edit',   as: 'edit_post'
    patch 'posts/:id'      => 'posts#update', as: 'update_post'
  end
  
  # 検索関連
  get "/search", to: "searches#search"
  
  # いいね関連
  resources :favorites, only: [:index]
  
  
# 管理者
  get "/admin" => "admin/homes#top"

  namespace :admin do
    # 管理者ホーム
    get 'homes/top'
    
    # ユーザー管理
    resources :users, only: [:index, :show, :edit, :update]
    
    # 投稿管理
    resources :posts, only: [:index, :show, :edit, :create]
  end

  # Deviseのルーティング
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
