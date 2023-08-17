class Comment < ApplicationRecord
  belongs_to :episode
  belongs_to :user
  
  # 関連するnotificationを削除するためのメソッド
  has_noticed_notifications
  
  with_options presence: true do
    validates :content
  end
end
