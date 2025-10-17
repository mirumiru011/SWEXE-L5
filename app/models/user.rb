class User < ApplicationRecord
  has_secure_password 

  # バリデーション
  validates :uid, 
    presence: true, 
    uniqueness: { case_sensitive: false }, 
    length: { minimum: 4, maximum: 20 }

  # 関連付け
  has_many :tweets
  has_many :likes
  has_many :like_tweets, through: :likes, source: :tweet
  
  has_one :profile, dependent: :destroy # 追加: ユーザーが削除されたらプロフィールも削除
end
