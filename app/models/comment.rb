class Comment < ApplicationRecord
  belongs_to :episode
  belongs_to :user

  with_options presence: true do
    validates :content
  end
end
