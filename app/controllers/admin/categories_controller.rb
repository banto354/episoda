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
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "カテゴリーを更新しました"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end
  
  def destroy
  end
  
  
  private
  
  def category_params
    params.require(:category).permit(:name, :parent)
  end
  
  def is_matching_login_user
    # 管理者ログインは認証済み
  end
end
