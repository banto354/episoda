class CategoryRelation < ApplicationRecord
  belongs_to :user, dependents: :destroy
  belongs_to :category, dependents: :destroy
end
