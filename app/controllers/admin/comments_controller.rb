class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    flash.now[:notice] = "コメントを削除しました"
  end
end
