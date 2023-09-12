# frozen_string_literal: true

class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

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
    category = Category.find(params[:id])
    category.destroy
    redirect_to admin_categories_path
  end


  private
    def category_params
      params.require(:category).permit(:name, :parent)
    end

    def is_matching_login_user
      # 管理者ログインは認証済み
    end
end
