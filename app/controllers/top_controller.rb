class TopController < ApplicationController
  # ツイート一覧表示
  def main
    @tweets = Tweet.all.order(created_at: :desc) 
  end

  # ログインフォーム表示用の新しいアクション
  def login_form

  end

  # ログイン処理
  def login
    user = User.find_by(uid: params[:uid])
    if user && user.authenticate(params[:pass]) 
      session[:login_uid] = user.uid
      redirect_to root_path, notice: "ログインしました。" # ログイン成功メッセージを追加
    else
      flash.now[:alert] = "ユーザーIDまたはパスワードが違います" # noticeをalertに変更して強調
      render :login_form, status: :unprocessable_entity # ログイン失敗時は login_form テンプレートを再表示
    end
  end

  # ログアウト処理
  def logout
    session.delete(:login_uid)
    redirect_to root_path, notice: "ログアウトしました。" # ログアウト成功メッセージを追加
  end
end