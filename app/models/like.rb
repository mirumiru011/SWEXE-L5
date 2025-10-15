class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
end

# app/models/user.rb
class User < ApplicationRecord
  has_many :tweets
  has_many :likes # 追加
  has_many :like_tweets, through: :likes, source: :tweet # 追加: 自分が「いいね」したツイート
end

# app/models/tweet.rb
class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes # 追加
  has_many :like_users, through: :likes, source: :user # 追加: このツイートを「いいね」したユーザー
end
