class Public::SearchesController < ApplicationController
  def index
    @query = params[:query]
    @users = User.where("name LIKE ?", "%#{@query}%")
    @episodes = Episode.where("title LIKE ?", "%#{@query}%")
  end
  
end
