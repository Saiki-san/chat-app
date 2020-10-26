class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
  end

  private

  # ルーム情報の取得
  def room_params
    #ルームのパラメーターをリクエスト、(nameとuser_ids:[]情報だけ)の編集を許可
    params.require(:room).permit(:name, user_ids: [])
  end
end