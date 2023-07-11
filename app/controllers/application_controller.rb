class ApplicationController < ActionController::Base
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :prevent_logged_in_user, only: [:new_session]


  
  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    if current_user
      episodes_path(current_user.id)
    else
      root_path(current_admin.id)
    end
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
    elsif admin_signed_in?
      redirect_to episodes_path, alert: "管理者アカウントでログイン済みです"
    end
  end
    
end
