class Episode < ApplicationRecord
  belongs_to :user
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :category_relations, dependent: :destroy
  has_many :categories, through: :category_relations

  # 単一フォーム複数モデル用設定
  accepts_nested_attributes_for :category_relations, reject_if: :all_blank, allow_destroy: true
  #to_group: 2は未実装
  enum visibility: { to_public: 0, to_myself: 1 }

  with_options presence: true do
    validates :title
    validates :content
    validates :visibility
  end

  def favourited_by?(user)
      favourites.exists?(user_id: user.id)
  end

  # def category_changed?(params)
  #   self.categories.first.id != params[:episode][:category_relations_attributes]["0"][:category_id].to_i
  # end

  after_create do
    episode = Episode.find_by(id: self.id)
    # contentカラムからハッシュタグを抽出
    tags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    tags.uniq.each do |tag|
      #ハッシュタグは先頭の'#'を外した上で保存
      hashtag = Tag.find_or_initialize_by(name: tag.downcase.delete('#'))
      episode.tags << hashtag
    end
  end

  after_update do
    episode = Episode.find_by(id: self.id)
    # contentカラムからハッシュタグを抽出
    tags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    # ハッシュタグの重複を削除
    tags.uniq!
    # 現在のタグと新しいタグの差分を取得
    old_tags = episode.tags.pluck(:name)
    new_tags = tags.map { |tag| tag.downcase.delete('#') }
    add_tags = new_tags - old_tags
    remove_tags = old_tags - new_tags
    # 追加するタグを関連付ける
    add_tags.each do |tag|
      hashtag = Tag.find_or_initialize_by(name: tag)
      episode.tags << hashtag
    end
    # 消去するタグを関連付け解除する
    remove_tags.each do |tag|
      hashtag = Tag.find_by(name: tag)
      episode.tags.delete(hashtag)
    end
  end

end
