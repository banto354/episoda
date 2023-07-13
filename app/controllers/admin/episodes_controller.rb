class Admin::EpisodesController < ApplicationController
  def index
    @episodes = Episode.page(params[:page]).per(10)
  end

  def show
    @episode = Episode.find(params[:id])
    @comments = Comment.where(episode_id: params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
  end
  
  def update
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      flash[:notice] = "編集を完了しました"
      redirect_to admin_episode_path(@episode)
    else
      render :edit
    end
  end
  
  def destroy
    episode = Episode.find(params[:id])
    user = episode.user
    episode.destroy
    redirect_to admin_user_path(user)
  end
  private
  
  def episode_params
    params.require(:episode).permit(:title, :content, :visibility, :group_id)
  end
  
  def is_matching_login_user
  end
end
