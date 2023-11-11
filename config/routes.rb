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
    get   'user/my_page' => "users#show"
    get   'user/quit' => "users#quit"
    patch 'user/withdraw' => "users#withdraw"
    resources :users, only: [:index, :show, :edit, :update]
  end

  scope module: :customer do
    get 'tag/index' => "tags#index"
  end

  scope module: :customer do
    # get 'post/edit'
    # get 'post/update'
    # get 'post/destroy'
    # get 'post/show'
    resources :posts, only: [:new, :show, :edit, :update, :destroy]
  end

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
    get 'post/edit'
    get 'post/show'
  end


  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
