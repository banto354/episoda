class Admin::EpisodesController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @episodes = Episode.page(params[:page]).per(10)
  end

  def show
    @episode = Episode.find(params[:id])
    @categories = @episode.categories
    @comments = Comment.where(episode_id: params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
    unless CategoryRelation.find_by(episode_id: @episode.id)
      @episode.category_relations.build
    end
    @categories = Category.all
  end

  def update
    @episode = Episode.find(params[:id])
    selected_categories_ids = params[:episode][:category_ids]
    new_categories = Category.where(id: selected_categories_ids)
    @episode.categories = new_categories
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
    params.require(:episode).permit(:title, :content, :visibility, :group_id, category_relations_attributes: [:category_id])
  end

  def is_matching_login_user
  end
end
