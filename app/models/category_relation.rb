class CategoryRelation < ApplicationRecord
  belongs_to :episode, dependent: :destroy
  belongs_to :category, dependent: :destroy
  
  with_options presence: true do
    validates :episode_id
    validates :category_id
  end
end
