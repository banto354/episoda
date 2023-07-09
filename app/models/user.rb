class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  # validate :image_size_validation
  
  has_many :episodes, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
    # 半角英数字のみを許可する正規表現（英字は小文字のみ）
  ALPHANUMERIC_REGEX = /\A[a-z0-9]+\z/
  validates :username, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true, format: { with: ALPHANUMERIC_REGEX }
  validates :introduction, length: { maximum: 400 }
  validates :email, uniqueness: true
  
  # ユーザー画像サイズ変換
  def get_profile_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # def image_size_validation
  #   if image.attached?
  #     if image.blob.byte_size > 1.megabytes
  #       image.purge
  #       errors.add(:image, "は1MB以下でなければなりません")
  #     end
  #   end
  # end
end
