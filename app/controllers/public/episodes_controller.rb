class Public::EpisodesController < ApplicationController
  before_action :is_public?, only: [:show]
  
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

  def is_matching_login_user
    episode = Episode.find(params[:id])
    unless episode.user.id == current_user.id
      flash[:alert]="ユーザーが一致しません"
      redirect_to user_path(current_user.id) 
    end
  end
  
  def is_public?
    episode = Episode.find(params[:id])
    if episode.visibility == 1 
      flash[:notice] = "この投稿は公開されていません"
      redirect_to root_path
    elsif episode.visibility == 2
      # グループ設定
      flash[:notice] = "この投稿は指定されたグループにのみ公開されています"
      redirect_to root_path
    end
  end
  
end
