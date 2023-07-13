class Public::SearchesController < ApplicationController
  def index
    @query = params[:query]
    @users = User.where("name LIKE ?", "%#{@query}%")
    # ユーザー検索結果から検索者を
    @users = @users.where.not(id: current_user.id) unless current_user.nil?
    @episodes = Episode.where("title LIKE ?", "%#{@query}%")
  end

end