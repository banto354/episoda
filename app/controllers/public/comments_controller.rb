class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :is_matching_login_user, only: [:destroy]
  def create
    # コメント保存
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.episode_id = params[:episode_id]
    # 引き渡しデータ格納
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    if comment.save
      # 通知(投稿者自身によるコメント除く)
      unless comment.user == comment.episode.user
        notification = CommentNotification.with(comment: comment)
        notification.deliver(@episode.user)
      end
      # flash[:notice] = "コメントを投稿しました"
    else
      render "episodes/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @comments = Comment.where(episode_id: params[:episode_id])
    @episode = Episode.find(params[:episode_id])
    flash[:success] = "コメントを削除しました"
    redirect_to episode_path(comment.episode)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def is_matching_login_user
    comment = Comment.find(params[:id])
    unless comment.user == current_user
      flash[:alert] = "ユーザーが一致しません"
      redirect_to user_path(current_user)
    end
  end
end
