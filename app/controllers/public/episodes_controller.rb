class Public::EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_public?, only: [:show]

  def index
    following_user_ids = current_user.following.pluck(:id)
    @episodes_following = Episode.where(user_id: following_user_ids).order("created_at DESC").limit(40).page(params[:page]).per(5)
    @episodes = Episode.where(visibility: 0).order("RAND()").limit(40).page(params[:page]).per(5)
    @categories = Category.all
  end

  def show
    @episode = Episode.find(params[:id])
    @comments = Comment.where(episode_id: params[:id])
    # 閲覧数カウント（3時間以内の同一ユーザーの閲覧はカウントしない）
    unless ViewCount.where('user_id = ? AND episode_id = ? AND created_at >= ?', current_user.id, params[:id], 3.hours.ago).present?
      view_count = ViewCount.new(user_id: current_user.id, episode_id: params[:id])
      view_count.save
    end
    # 閲覧数表示用
    @view_counts = ViewCount.where(episode_id: params[:id]).count
  end

  def new
    @episode = Episode.new
    @episode.category_relations.build
    @categories = Category.all
  end

  def create
    @episode = Episode.new(episode_params)
    @episode.user_id = current_user.id
    if @episode.save
        flash[:success] = "投稿に成功しました"
        redirect_to user_path(current_user)
    else
      @episode.category_relations.build
      @categories = Category.all
      render :new
    end
  end

  def edit
    @episode = Episode.find(params[:id])
    @categories = Category.all
    if CategoryRelation.find_by(episode_id: params[:id]).nil?
      byebug
      @episode.category_relations.build
    else
      byebug
    end
  end

  def update
    @episode = Episode.find(params[:id])

    if @episode.update(episode_params)
      flash[:success] = "編集を完了しました"
      redirect_to user_path(current_user)
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    episode = Episode.find(params[:id])
    episode.destroy
    redirect_to user_path(current_user)
  end

  def hashtag
    @user = current_user
    @tag = Tag.find_by(name: params[:name])
    @episodes = @tag.episodes.page(params[:page]).per(6)
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :content, :visibility, :group_id, category_relations_attributes: [:category_id])
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
