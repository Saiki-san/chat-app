class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # has_one_attachedメソッド：各レコードとファイルを1対1の関係で紐づけるメソッド。
  # has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付できる
  # 「:ファイル名」には、添付するファイルがわかる名前をつける。
  # この記述により、「モデル.ファイル名」(例：Message.〜image)で、添付されたファイルにアクセスできるようになる
  # このとき、messagesテーブルにカラムを追加は不要。
  has_one_attached :image
  # メッセージ(content)送信時にroomが空欄だった場合、作成できない様に設定。
  validates :content, presence: true
end
