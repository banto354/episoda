class Category < ApplicationRecord
  has_many :episodes, through: :category_relations
  has_many :category_relations, dependent: :destroy

  with_options presence: true do
    validates :name
  end

  enum parent: { emotion: 0, genre: 1, year: 2 }
end
