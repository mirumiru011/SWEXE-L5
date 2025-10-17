class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in? # ヘルパーメソッドとしてビューでも使えるようにする

  private

  def current_user
    @current_user ||= User.find_by(uid: session[:login_uid]) if session[:login_uid]
  end

  def logged_in?
    current_user.present?
  end

  def authenticate_user
    unless logged_in?
      redirect_to root_path, alert: "ログインしてください。"
    end
  end
end
