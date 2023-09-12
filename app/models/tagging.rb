# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :episode
  belongs_to :tag

  with_options presence: true do
    validates :episode_id
    validates :tag_id
  end
end
