class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # メッセージ(content)送信時にroomが空欄だった場合、作成できない様に設定。
  validates :content, presence: true
end
