class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    if @user == current_user
      @episodes = Episode.where(user_id: current_user.id).order("created_at DESC").page(params[:episode_page]).per(10)
    else
      @episodes = Episode.where(user_id: params[:id], visibility: 0).order("created_at DESC").page(params[:episode_page]).per(10)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def check
  end

  def withdrawal
    user = User.find(current_user.id)
    user.update(is_active: false)
    reset_session
    flash[:alert] = "退会処理が実行されました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :username, :birthdate, :email, :introduction, :is_public, :is_active)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert]="ユーザーが一致しません"
      redirect_to user_path(current_user.id)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      flash[:alert]= "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to user_path(current_user)
    end
  end
end
