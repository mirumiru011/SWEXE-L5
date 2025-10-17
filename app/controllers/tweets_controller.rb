class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:create]# 自分のツイートのみ削除可能にする

  # ツイートの作成（投稿処理）
  def create
    user = current_user # current_user ヘルパーメソッドを使用
    @tweet = user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to root_path, notice: "ツイートを投稿しました。"
    else
      flash[:alert] = "ツイートの投稿に失敗しました。"
      redirect_to root_path # エラー時はメイン画面に戻る
    end
  end

  # ツイートの削除
  def destroy
    @tweet = Tweet.find(params[:id]) 
    @tweet.destroy
    redirect_to root_path, notice: "ツイートを削除しました。"
  rescue ActiveRecord::RecordNotFound 
    redirect_to root_path, alert: "削除対象のツイートが見つかりませんでした。"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  # ログイン中のユーザーがツイートの所有者か確認する
  def ensure_correct_user_for_tweet
    @tweet = Tweet.find(params[:id])
    unless @tweet.user == current_user
      redirect_to root_path, alert: "他のユーザーのツイートは削除できません。"
    end
  rescue ActiveRecord::RecordNotFound # ツイートが見つからない場合
    redirect_to root_path, alert: "削除対象のツイートが見つかりませんでした。"
  end
end
