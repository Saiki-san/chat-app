class MessagesController < ApplicationController
  # messagesコントローラーにindexアクションを定義
  def index
    # 空のMessageモデルのインスタンス情報
    @message = Message.new
    # (Roomモデルより)paramsに含まれているチャットルームのレコード情報を取得
    @room = Room.find(params[:room_id])
  end

  # messagesコントローラーにcreateアクションを定義
  def create
    @room = Room.find(params[:room_id])
    # チャットルームに紐づいたメッセージのインスタンスを生成
    @message = @room.messages.new(message_params)
    # メッセージの内容をmessagesテーブルに保存
    # DBに値が保存された場合
    if @message.save
      # 投稿したメッセージ一覧画面に遷移
      # messagesコントローラーのindex(room_messages_path)アクションに再度リクエストを送信し、新たにインスタンス変数を生成。これによって保存後の情報に更新される。
      redirect_to room_messages_path(@room)
    else
      # 保存に失敗した場合は、同じページ(messagesのindexページ)に戻る
      # indexアクションのインスタンス変数はそのまま
      render :index
    end
  end

  private

  def message_params
    # パラメーターの中に、ログインしているユーザーのid(current_user.id)と紐付いている、メッセージの内容(content)を受け取れるように許可。
    # メッセージの内容(content)をmessagesテーブルへ保存できるように。
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end
