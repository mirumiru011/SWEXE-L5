class TweetsController < ApplicationController
  # ツイートの作成（投稿処理）
  def create
    # 1. ログイン中のユーザーを取得
    # ※ ログイン機能が正しく動作し、session[:login_uid]に値が入っていることが前提
    user = User.find_by(uid: session[:login_uid]) 
    
    # 2. ユーザーの関連付けを使って新しいツイートを作成
    # user.tweets.newを使うと、tweetのuser_idカラムが自動でセットされます
    @tweet = user.tweets.new(tweet_params)

    if @tweet.save
      redirect_to root_path, notice: "ツイートを投稿しました。"
    else
      # エラー処理。通常はrender 'top/main'でトップ画面を再表示
      # ただし、top#mainで使う@tweetsの再定義が必要です
      flash[:alert] = "ツイートの投稿に失敗しました。"
      redirect_to root_path
    end
  end

  private

  def tweet_params
    # message のみを許可
    params.require(:tweet).permit(:message)
  end
end
