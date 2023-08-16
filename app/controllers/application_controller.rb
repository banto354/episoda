class ApplicationController < ActionController::Base
  before_action :prevent_logged_in_user, only: [:new_session]
  before_action :is_active?


  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    if current_user
      episodes_path
    else
      admin_users_path
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
      redirect_to admin_episodes_path, alert: "管理者アカウントでログイン済みです"
    end
  end

  # 退会処理済みユーザーをトップページへと戻す
  def is_active?
    if user_signed_in?
      unless current_user.active_for_authentication?
        flash[:alert] = "このアカウントは退会済みです。アカウントを登録し直してください"
        redirect_to root_path
      end
    end
  end
end
