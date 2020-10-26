class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string     :content
      # 「references :カラム名」で別テーブルのカラムを参照。room(user)の部分が外部key
      # 「foreign_key: ture」で、カラムの有無を確認(参照)。有ることが前提。
      t.references :room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end