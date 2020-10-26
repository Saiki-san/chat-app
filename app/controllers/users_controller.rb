class UsersController < ApplicationController
  #editアクションを定義
  def edit
  end

  #updateアクションを定義
  def update
    #ユーザー情報が格納されているcurrent_userメソッドを使用して、ログインしているユーザーの情報(Userモデルにおける、現ユーザー情報)を更新
    #(印数user_params)、↓のpermitよりnameとemailだけ更新
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  #ユーザー情報の取得
  def user_params
    #ユーザーのパラメーターをリクエスト、(nameとemail情報だけ)の編集を許可
    params.require(:user).permit(:name, :email)
  end
end
