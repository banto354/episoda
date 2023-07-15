class Tag < ApplicationRecord
  has_many :taggings
  has_many :episodes, through: :taggings

  validates :name, presence: true, length: {maximum:30}  
end
