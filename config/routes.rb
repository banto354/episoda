Rails.application.routes.draw do
  root to:'public/homes#top'
  get '/about' => 'public/homes#about'

  # ユーザー用
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者用
  devise_for :admin,  skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions",
  }

  scope module: :public do
    patch 'users/withdrawal' => "users#withdrawal", as: 'withdrawal_user'
    get 'users/check' => "users#check", as: 'check_user'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      collection do
        get 'followers'
        get 'following'
      end
    end
    resources :episodes, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resource :favourite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :notifications, only: [:index]
    resources :searches, only: [:index]
    resources :categories, only: [:show]
    get '/categories/subcategories' => 'categories#subcategories'
    get '/tag/:name', to: "episodes#hashtag"
    get '/favourites/index' => 'favourites#index', as: 'favourites_index'
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :episodes, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
    resources :searches, only: [:index]
    resources :categories, only: [:index, :create, :edit, :update, :destroy]
  end

  devise_scope :user do
    post "users/guest_sign_in" => "users/sessions#guest_sign_in"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
