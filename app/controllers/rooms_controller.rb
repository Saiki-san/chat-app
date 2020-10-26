class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  # ルーム作成
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  # ルーム削除
  def destroy
    # (Roomモデルより)削除したいチャットルームの情報(ルームid[:id])を取得
    room = Room.find(params[:id])
    # destroyアクションは、削除するだけなのでビューの表示は不要。。
    # そのため、インスタンス変数(@〜)ではなく変数としてroomを定義し、destroyメソッドを使用。
    room.destroy

    redirect_to root_path
  end

  private

  # ルーム情報の取得
  def room_params
    #ルームのパラメーターをリクエスト、(nameとuser_ids:[]情報だけ)の編集を許可
    params.require(:room).permit(:name, user_ids: [])
  end
end