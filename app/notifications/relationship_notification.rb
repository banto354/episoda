# To deliver this notification:
#
# RelationshipNotification.with(post: @post).deliver_later(current_user)
# RelationshipNotification.with(post: @post).deliver(current_user)

class RelationshipNotification < Noticed::Base
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
      user: params[:follower].name, 
    }
  end
  #
   def url
   {
     user_path(params[:follower])
   }
   end
end
