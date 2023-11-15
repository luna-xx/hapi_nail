Rails.application.routes.draw do

  devise_for :users
  
  devise_scope :user do
    get '/users', to: redirect("/users/sign_up")
    # ゲストユーザーログイン
    post 'users/guest_sign_in', to: "customer/sessions#guest_sign_in"
  end
#"表示URL"=>"controller#action" で表示ページを記載
  root to: 'customer/homes#top'
    #get 'top' => 'customer/homes#top'

  scope module: :customer do
    resources :users, only: [:index, :edit, :update, :create]
    get   'user/my_page' => "users#show"
    get   'user/quit' => "users#quit"
    patch 'user/withdraw' => "users#withdraw"
  end

  scope module: :customer do
    get 'tag/index' => "tags#index"
    # タグ検索
    get 'search_tag' => "posts#search_tag"
  end

  scope module: :customer do
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource  :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    get 'posts/:id/edit' => 'posts#edit', as: 'edit_post'
    patch 'posts/:id' => 'posts#update', as: 'update_post'
  end
  
  get "/search", to: "searches#search"
  
  resources :favorites, only: [:index]
  
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  get "/admin" => "admin/homes#top"

  namespace :admin do
    get 'homes/top'
  end

  namespace :admin do
    get 'user/index'
    get 'user/show'
    get 'user/edit'
    get 'user/update'
  end

  namespace :admin do
    post 'posts' => 'posts#create'
    resources :posts, only: [:index, :show, :edit]
  end


  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
