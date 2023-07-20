class Public::CategoriesController < ApplicationController
  def subcategories
    # パラメータから親カテゴリのIDを取得
    parent_id = params[:parent_id]

    # 子カテゴリのデータを取得する処理
    @subcategories = Category.where(parent: parent_id) #enumを用いる必要性？

    # レスポンスを返す
    respond_to do |format|
      format.json { render json: @subcategories }
    end    
  end
  
  
end
