# 中間テーブル(rooms - users)
class CreateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :room_users do |t|
      # 「references :カラム名」で別テーブルのカラムを参照。room(user)の部分が外部key
      # 「foreign_key: ture」で、カラムの有無を確認(参照)。有ることが前提。
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
