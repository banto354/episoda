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
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
