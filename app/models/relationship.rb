# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # 関連するnotificationを削除するためのメソッド
  has_noticed_notifications

  with_options presence: true do
    validates :follower_id
    validates :followed_id
  end
end
