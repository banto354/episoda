class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about] 
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
        byebug
      end  
      byebug
      # flash[:success] = "コメントを投稿しました"
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
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
