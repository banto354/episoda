class Episode < ApplicationRecord
  
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  enum visibility: { to_public: 0, to_group: 1, to_myself: 2 }
  
  def favourited_by?(user)
      favourites.exists?(user_id: user.id)
  end
  
end
