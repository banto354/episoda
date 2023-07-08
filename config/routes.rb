Rails.application.routes.draw do


  root to:'public/homes#top'

  # ユーザー用
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者用
  devise_for :admin, controllers: {
  sessions: "admin/sessions"
  }

  get '/about' => 'public/homes#about'
  scope module: :public do
    patch 'users/withdrawal' => "users#withdrawal", as: 'withdrawal_user'
    get 'users/check' => "users#check", as: 'check_user'
    resources :users, only: [:show, :edit, :update]
    resources :episodes, only: [:index, :show, :new, :create, :edit, :update] do
      resource :favourite, only: [:create, :destroy]
    end
  end

  namespace :admin do
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
