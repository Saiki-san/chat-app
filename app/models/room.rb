class Room < ApplicationRecord
  has_many :room_users
  has_many :users, through: :room_users
  # ルーム作成時にroomが空欄だった場合、作成できない様に設定。
  validates :room, presence: true

end
