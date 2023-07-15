class Tagging < ApplicationRecord
  belongs_to :episode, dependent: :destroy
  belongs_to :tag, dependent: :destroy
  
  validates  :episode_id, presence: true
  validates  :tag_id,   presence: true
end
