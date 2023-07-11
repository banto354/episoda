class Admin::EpisodesController < ApplicationController
  def index
    @episodes = Episode.page(params[:page]).per(10)
  end

  def show
    @episode = Episode.find(params[:id])
  end

  def edit
    @episode = Episode.find(params[:id])
  end
  
  private
  
  def episode_params
    params.require(:episode).permit(:title, :content, :visibility, :group_id)
  end
  
  def is_matching_login_user
  end
end
