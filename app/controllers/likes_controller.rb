class LikesController < ApplicationController
  # いいね！の追加 (POST /tweets/:tweet_id/likes)
  def create
    # params[:tweet_id] は既にルーティングによって渡される
    tweet = Tweet.find(params[:tweet_id]) 

    unless tweet.liked?(current_user)
      tweet.like(current_user)
    end

    redirect_to root_path
  end

  # いいね！の削除 (DELETE /tweets/:tweet_id/likes)
  def destroy
    # ルーティングの変更により、params[:tweet_id]でツイートIDを取得
    tweet = Tweet.find(params[:tweet_id]) 

    if tweet.liked?(current_user)
      tweet.unlike(current_user)
      flash[:notice] = "いいね！を取り消しました。"
    else
      # ここは通常発生しないが、安全のため残す
      flash[:alert] = "いいね！が見つかりませんでした。" 
    end

    redirect_to root_path
  end
end