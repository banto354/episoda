class Admin::CommentsController < ApplicationController
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    flash[:success] = "コメントを削除しました"
    redirect_to admin_episode_path(comment.episode)
  end
end
