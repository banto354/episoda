# frozen_string_literal: true

class Public::NotificationsController < ApplicationController
  def index
    # ユーザー未読のお知らせを格納
    @notifications = current_user.notifications.newest_first.where("created_at >= ?", 7.days.ago)
    # 格納した通知を既読にする
    @notifications.each do |notification|
      notification.mark_as_read!
    end
  end
end
