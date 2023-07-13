class Admin::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @category = Category.new
  end
  
  def create
    category = Category.new(category_params)
    if category.save
      flash[:notice] = "カテゴリーを追加しました"
      redirect_to admin_categories_path
    else
      render admin_categories_path
    end
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name, :variety)
  end
  
  def is_matching_login_user
    # 管理者ログインは認証済み
  end
end
