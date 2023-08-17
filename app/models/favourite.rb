class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  
  # 関連するnotificationを削除するためのメソッド
  has_noticed_notifications
  
  with_options presence: true do
    validates :user_id
    validates :episode_id
  end
end
