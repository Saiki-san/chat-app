class ApplicationController < ActionController::Base
  #ログインしてるか否かを判定。ログインしていたら次のメソッドへ
  before_action :authenticate_user!
  # devise_controlloerの有無を判定し、あった場合に次のメソッドを開始
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
