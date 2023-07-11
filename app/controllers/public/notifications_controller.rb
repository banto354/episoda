class Public::NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications
    
    @notifications.unread.each do |notification|
      notification.mark_as_read!
    end
  end
end
