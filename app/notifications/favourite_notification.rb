# frozen_string_literal: true

# To deliver this notification:
#
# FavourtiteNotification.with(post: @post).deliver_later(current_user)
# FavourtiteNotification.with(post: @post).deliver(current_user)

class FavouriteNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  # def message
  #   t(".message")
  # end
  def message
    {
      user: params[:favourite].user.name,
      episode: params[:favourite].episode.title
    }
  end

  def url
    {
      user: user_path(params[:favourite].user),
      episode: episode_path(params[:favourite].episode)
    }
  end
end
