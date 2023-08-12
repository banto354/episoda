class CategoryRelation < ApplicationRecord
  belongs_to :episode, optional: true
  belongs_to :category, optional: true

end
