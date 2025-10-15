class Tweet < ApplicationRecord
  # 1. 1:多 (ユーザー)
  belongs_to :user

  # 2. 多:多 (いいね) のための定義
  # ---
  # 中間テーブルである Like モデルへの関連付け
  has_many :likes
  
  # Like モデルを経由して、いいね!した User へ関連付ける
  # through: :likes  -> 仲介役は :likes
  # source: :user   -> :likes の中の :user_id を使って参照する
  has_many :like_users, through: :likes, source: :user
end