class Public::FavouritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @episode = Episode.find(params[:episode_id])
    favourite = Favourite.new(user_id: current_user.id, episode_id: params[:episode_id])
    if  favourite.save
      # 通知(投稿者自身によるいいね除く)
      unless favourite.user == favourite.episode.user
        notification = FavouriteNotification.with(favourite: favourite)
        notification.deliver(@episode.user)
      end
    else
      render "episodes/show"
    end
  end

  def destroy
    @episode = Episode.find(params[:episode_id])
    favourite = Favourite.find_by(user_id: current_user.id, episode_id: params[:episode_id])
    favourite.destroy
  end
  
end
