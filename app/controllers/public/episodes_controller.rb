class Public::EpisodesController < ApplicationController
  def index
    @episodes = Episode.where(is_public: true)
  end

  def show
    @episode = Episode.find(params[:id])
    @comments = Comment.where(episode_id: params[:id])
  end

  def new
    @episode = Episode.new
  end
  
  def create
    episode = Episode.new(episode_params) 
    episode.user_id = current_user.id
    if episode.save
      flash[:success] = "投稿をしました"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @episode = Episode.find(params[:id])
  end
  
  def update
    @episode = Episode.find(params[:id])
    if @episode.update(episode_params)
      flash[:success] = "編集を完了しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  private
  
  def episode_params
    params.require(:episode).permit(:title, :content, :visibility, :group_id)
  end
end