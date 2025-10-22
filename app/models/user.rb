class User < ApplicationRecord
  has_secure_password

  # バリデーション
  validates :uid,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 20 }

  # 関連付け (削除伝搬を追加)
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_tweets, through: :likes, source: :tweet

  has_one :profile, dependent: :destroy
end
