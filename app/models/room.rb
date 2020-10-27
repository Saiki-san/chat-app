class Room < ApplicationRecord
  has_many :room_users
  # dependentオプション：親モデルを削除した時に、親モデルと関連している子モデルに対する挙動を指定するオプション。
  # dependentオプションに:destroyを指定したときは、親モデルが削除されたとき、それに紐付ている子モデルも一緒に削除される
  # Room（親モデル）が削除されたときに、Message（子モデル）とUser（子モデル）が通るRoomUser（中間テーブルのモデル）も削除。
  # これで、roomを削除したとき、roomに関連するmessagesテーブルのレコードとroom_usersテーブルのレコードも、一緒に削除されるように設定
  has_many :users, through: :room_users, dependent: :destroy
  has_many :messages, dependent: :destroy
  # ルーム作成時にチャットルーム名(roomsテーブルのnameカラム)が空欄だった場合、作成できない様に設定。
  validates :name, presence: true

end
