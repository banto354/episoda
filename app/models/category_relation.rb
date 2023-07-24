class CategoryRelation < ApplicationRecord
  belongs_to :episode, dependent: :destroy, optional: true
  belongs_to :category, dependent: :destroy, optional: true

  with_options presence: true do
    validates :category_id
  end
end
