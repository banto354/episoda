# frozen_string_literal: true

class Public::CategoriesController < ApplicationController
  def subcategories
    # パラメータから親カテゴリのIDを取得
    parent_id = params[:parent_id]

    # 子カテゴリのデータを取得する処理
    @subcategories = Category.where(parent: parent_id)

    # レスポンスを返す
    respond_to do |format|
      format.json { render json: @subcategories }
    end
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @episodes = @category.episodes.page(params[:page]).per(10)
  end
end
