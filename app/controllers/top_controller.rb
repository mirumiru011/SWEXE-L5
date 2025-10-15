class TopController < ApplicationController
  # ツイート一覧表示とログインフォームの表示
  def main
    # すべてのツイートを取得
    @tweets = Tweet.all.order(created_at: :desc) 
    
    # ログインしていない場合は、ログインフォームを表示する
    unless session[:login_uid]
      # ログインフォームは top/login_form.html.erb などに作成し、renderで表示する
      # ファイルがない場合はエラーになるので注意
      render :login_form
    end
    # ログインしている場合は、main.html.erb（ツイート一覧）がそのまま表示される
  end

  # ログイン処理
def login
  user = User.find_by(uid: params[:uid])
  if user && user.authenticate(params[:pass]) # 🔥 BCrypt認証
    session[:login_uid] = user.uid
    redirect_to root_path
  else
    flash.now[:notice] = "ユーザーIDまたはパスワードが違います"
    render :login_form
  end
end

  # ログアウト処理
  def logout
    # セッションからユーザーID情報を削除
    session.delete(:login_uid)
    # トップページへリダイレクト
    redirect_to root_path
  end
end