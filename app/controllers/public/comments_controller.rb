class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about] 
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.episode_id = params[:episode_id]
    comment.save
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    flash[:success] = "コメントを投稿しました"
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    flash[:success] = "コメントを削除しました"
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
