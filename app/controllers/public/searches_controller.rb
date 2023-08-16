class Public::SearchesController < ApplicationController
  def index
    @query = params[:query]
    @users = User.where("name LIKE ?", "%#{@query}%").order("created_at DESC").page(params[:user_page]).per(3)
    # ユーザー検索結果から検索者を除外
    @users = @users.where.not(id: current_user.id) unless current_user.nil?

    episodes = Episode.where("title LIKE ?", "%#{@query}%").order("created_at DESC")
    @episodes = episodes.where(visibility: 0).page(params[:episode_page]).per(6)
    # 'もっとみる'ページネーション設定
    return unless request.xhr?

    case params[:type]
    when 'user', 'episode'
      render "#{params[:type]}"
    end
  end

end
