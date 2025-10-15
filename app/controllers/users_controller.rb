class UsersController < ApplicationController
  def index
    @users = User.all
  end

  # 新規ユーザー登録フォーム
  def new
    @user = User.new
  end

  # ユーザー登録処理
  def create
    # has_secure_password を使用するため、パスワードフィールドは :password と :password_confirmation で受け取ります
    @user = User.new(user_params)
    if User.exists?(uid: @user.uid)
      flash.now[:alert] = "ユーザーID '#{@user.uid}' は既に使われています。"
      render :new, status: :unprocessable_entity
      return
    end

    if @user.save
      session[:login_uid] = @user.uid
      redirect_to root_path, notice: "ユーザー「#{@user.uid}」を登録しました。"
    else
      # バリデーションエラー時はフォームを再表示
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user_to_delete = User.find_by(uid: params[:id])
    
    if user_to_delete
      user_to_delete.destroy
      # 削除したユーザーがログイン中の場合はセッションも破棄
      if session[:login_uid] == user_to_delete.uid
        session[:login_uid] = nil
        flash[:notice] = "ユーザー「#{user_to_delete.uid}」とログインセッションを削除しました。"
      else
        flash[:notice] = "ユーザー「#{user_to_delete.uid}」を削除しました。"
      end
    else
      flash[:alert] = "ユーザーが見つかりませんでした。"
    end
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:uid, :password, :password_confirmation) 
  end
end
