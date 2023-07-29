class Tagging < ApplicationRecord
  belongs_to :episode
  belongs_to :tag

  validates  :episode_id, presence: true
  validates  :tag_id,   presence: true
end
