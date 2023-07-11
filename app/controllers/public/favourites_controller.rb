class Public::FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @episode = Episode.find(params[:episode_id])
    favourite = Favourite.new(user_id: current_user.id, episode_id: params[:episode_id])
    favourite.save
  end

  def destroy
    @episode = Episode.find(params[:episode_id])
    favourite = Favourite.find_by(user_id: current_user.id, episode_id: params[:episode_id])
    favourite.destroy
  end
  
end
