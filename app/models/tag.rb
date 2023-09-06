# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :episodes, through: :taggings

  validates :name, presence: true, length: { maximum: 30 }
end
