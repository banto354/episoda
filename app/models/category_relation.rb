class CategoryRelation < ApplicationRecord
  belongs_to :episode, optional: true
  belongs_to :category, optional: true

  with_options presence: true do
    validates :category_id
  end
end
