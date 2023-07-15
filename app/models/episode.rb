class Episode < ApplicationRecord
  
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings  
  
  enum visibility: { to_public: 0, to_group: 1, to_myself: 2 }
  
  def favourited_by?(user)
      favourites.exists?(user_id: user.id)
  end
  
  after_create do
    episode = Episode.find_by(id: self.id)
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.each do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
      hashtag = Tag.find_or_create_by(name: tag.downcase.delete('#'))
      episode.tags << hashtag
    end
  end    
end
