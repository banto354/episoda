class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :episode
  
  with_options presence: true do
    validates :user_id
    validates :episode_id
  end
end
