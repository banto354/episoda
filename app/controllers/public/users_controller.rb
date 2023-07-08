class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @posts = Post.where(user_id: current_user.id)
    else
      @posts = Post.where(user_id: params[:id], visibility: 0)
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
    flash[:danger] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:image, :name, :username, :birthdate, :email, :introduction)
  end
end
