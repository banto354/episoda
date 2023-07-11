# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
   param :comment

  # Define helper methods to make rendering easier.
  #
  def message
    {
      user: params[:comment].user.name, 
      episode: params[:comment].episode.title
    }
  end
  #
  def url
    {
     user: user_path(params[:comment].user),
     episode: episode_path(params[:comment].episode)
    }
  end
end
