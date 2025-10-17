class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :authenticate_user, only: [:new, :create, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    # ログインユーザーが既にプロフィールを持っている場合は編集画面へリダイレクト
    if current_user.profile.present?
      redirect_to edit_profile_path(current_user.profile), notice: "プロフィールは既に登録されています。編集してください。"
      return
    end
    @profile = current_user.build_profile # ログインユーザーに紐付く新しいプロフィールを作成
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to profile_path(@profile), notice: "プロフィールを登録しました。"
    else
      flash.now[:alert] = "プロフィールの登録に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @profile は before_action でセットされる
  end

  def edit
    # @profile は before_action でセットされる
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "プロフィールを更新しました。"
    else
      flash.now[:alert] = "プロフィールの更新に失敗しました。"
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:introduction, :location)
  end

  # ログイン中のユーザーを取得するヘルパーメソッド（どこか共通の場所で定義すると良い）
  def current_user
    @current_user ||= User.find_by(uid: session[:login_uid]) if session[:login_uid]
  end

  # ログインしているかを確認する
  def authenticate_user
    unless session[:login_uid]
      redirect_to root_path, alert: "ログインしてください。"
    end
  end

  # プロフィールを編集・更新しようとしているのが、そのプロフィールの持ち主か確認する
  def ensure_correct_user
    unless @profile.user == current_user
      redirect_to root_path, alert: "権限がありません。"
    end
  end
end