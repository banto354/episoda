class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  def create
    # コメント保存
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.episode_id = params[:episode_id]
    # 引き渡しデータ格納
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    @comment_new = Comment.new
    if @comment.save
      # 通知(投稿者自身によるコメント除く)
      unless @comment.user == @comment.episode.user
        notification = CommentNotification.with(comment: @comment)
        notification.deliver(@episode.user)
      end
      # flash[:notice] = "コメントを投稿しました"
    else
      render :error_messages
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    # 引き渡しデータ格納
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    @comment_new = Comment.new
    flash[:success] = "コメントを削除しました"
    redirect_to episode_path(comment.episode)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
