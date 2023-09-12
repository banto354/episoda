# frozen_string_literal: true

class ViewCount < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :episode_id
  end
end
