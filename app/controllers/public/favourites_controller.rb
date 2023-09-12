# frozen_string_literal: true

class Public::FavouritesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(current_user.id)
    @episodes = user.favourite_episodes.order("favourites.created_at DESC").page(params[:page]).per(6)
  end

  def create
    @episode = Episode.find(params[:episode_id])
    favourite = Favourite.new(user_id: current_user.id, episode_id: params[:episode_id])
    if  favourite.save
      # 通知(投稿者自身によるいいね除く)
      unless favourite.user == favourite.episode.user
        # 通知データを処理
        notification = FavouriteNotification.with(favourite: favourite)
        # 通知先を処理
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
