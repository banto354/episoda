class Public::FavouritesController < ApplicationController

  def create
    favourite = Favourite.new(user_id: current_user.id, episode_id: params[:episode_id])
    favourite.save
    byebug
  end

  def destroy
    favourite = Favourite.find(user_id: current_user.id, episode_id: params[:episode_id])
    favourite.destroy
  end
  
end
