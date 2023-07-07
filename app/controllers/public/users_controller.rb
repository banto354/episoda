class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :username, :birthdate, :email, :introduction)
  end
end
