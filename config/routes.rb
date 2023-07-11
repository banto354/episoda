Rails.application.routes.draw do

  root to:'public/homes#top'
  get '/about' => 'public/homes#about'
  
  # ユーザー用
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者用
  devise_for :admin, controllers: {
  sessions: "admin/sessions",
  registrations: "admin/registrations"
  }

  scope module: :public do
    patch 'users/withdrawal' => "users#withdrawal", as: 'withdrawal_user'
    get 'users/check' => "users#check", as: 'check_user'
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followers' => 'relationships#followers', as: 'followers'
      get 'following' => 'relationships#following', as: 'following'
    end
    resources :episodes, only: [:index, :show, :new, :create, :edit, :update] do
      resource :favourite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
