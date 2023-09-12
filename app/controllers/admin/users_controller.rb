# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "#{@user.name}さんの会員情報が更新されました。"
      redirect_to admin_user_path(params[:id])
    else
      flash.now[:alert] = "未記入項目があります"
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:image, :name, :username, :birthdate, :email, :introduction, :is_public, :is_active)
    end

    # 管理者機能では編集先のidとの一致を求めない
    def is_matching_login_user
    end
end
