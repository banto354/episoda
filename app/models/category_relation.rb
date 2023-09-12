# frozen_string_literal: true

class CategoryRelation < ApplicationRecord
  belongs_to :episode, optional: true
  belongs_to :category, optional: true
end
