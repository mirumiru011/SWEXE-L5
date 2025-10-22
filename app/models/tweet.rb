class Tweet < ApplicationRecord
  # 1. 1:多 (ユーザー)
  belongs_to :user

  # 2. 多:多 (いいね) のための定義
  # ---
  # 中間テーブルである Like モデルへの関連付け (削除伝搬を追加)
  has_many :likes, dependent: :destroy

  # Like モデルを経由して、いいね!した User へ関連付ける
  # through: :likes  -> 仲介役は :likes
  # source: :user    -> :likes の中の :user_id を使って参照する
  has_many :like_users, source: :user, through: :likes

  # 以下の3つのメソッドを追加 (講義資料に記載のOOPメソッド)
  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  def liked?(user) # いいね済みか調べる(true / false)
    like_users.include?(user)
  end
end