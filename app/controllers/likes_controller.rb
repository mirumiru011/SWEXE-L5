class LikesController < ApplicationController
  # いいね！の追加 (POST /likes)
  def create
    # ログインユーザーはセッションから取得
    user = User.find_by(uid: session[:login_uid])
    
    # いいね！対象のツイートはパラメータから取得
    tweet = Tweet.find(params[:tweet_id])

    # 多:多の関連付けを利用してLikeレコードを生成
    # user.like_tweets << tweet は、Like.create(user_id: user.id, tweet_id: tweet.id) と同じ
    user.like_tweets << tweet 
    
    redirect_to root_path
  end

  # いいね！の削除 (DELETE /likes/:id)
  def destroy
    like = Like.find_by(id: params[:id])

    if like
      # 2. 認証なしでLikeレコードを削除 (演習の簡易仕様)
      like.destroy
      flash[:notice] = "いいね！を取り消しました。"
    else
      # Likeレコードが見つからなかった場合
      flash[:alert] = "削除対象のいいね！が見つかりませんでした。"
    end
    
    redirect_to root_path
  end
end