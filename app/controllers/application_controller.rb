class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :is_matching_login_user, only: [:new, :create, :edit, :update]
  before_action :prevent_logged_in_user, only: [:new_session]


  
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    user_path(current_user.id)
  end
  
  def after_sign_up_path_for(resouce)
    flash[:notice] = "新規ユーザー登録しました"
  end
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end
    
  private

  def prevent_logged_in_user
    if user_signed_in?
      redirect_to episodes_path, alert: "ログイン済みです"
    end
  end
    
end
