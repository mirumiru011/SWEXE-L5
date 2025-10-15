class ApplicationController < ActionController::Base
  def main
    if session[:login_uid]
      # ログイン済みの場合はツイート一覧ページへリダイレクト（仮）
      # 最終的には main.html.erb ですべてのツイートを表示する
      @tweets = Tweet.all.order(created_at: :desc)
    else
      # ログインフォームを表示
      render :login_form
    end
  end

  def login
    user = User.find_by(uid: params[:uid], pass: params[:pass]) # BCrypt未実装の仮
    if user
      session[:login_uid] = user.uid # セッションにuidを保持
      redirect_to root_path
    else
      flash.now[:notice] = "ユーザーIDまたはパスワードが違います"
      render :login_form
    end
  end

  def logout
    session.delete(:login_uid)
    redirect_to root_path
  end
end
