class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  # has_one_attachedメソッド：各レコードとファイルを1対1の関係で紐づけるメソッド。
  # has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付できる
  # 「:ファイル名」には、添付するファイルがわかる名前をつける。
  # この記述により、「モデル.ファイル名」(例：Message.〜image)で、添付されたファイルにアクセスできるようになる
  # このとき、messagesテーブルにカラムを追加は不要。
  has_one_attached :image
  # メッセージ(content)送信時にcontentが空欄だった場合、送信できない様に設定。
  # unlessにより、was_attached?で画像が添付されてない状態(false)であれば、バリデーションで検証を行う仕様に。
  # つまり、画像が添付されていれば、content無しでOK。画像が添付されていなければcontentが必要。(どちらか片方必須の制約)
  # アソシエーションでbelongs_toを指定した場合は、
  # 外部キー（今回はuser_id。例：validates :user_id presence: true ←不要）が存在するというバリデーションは不要
  validates :content, presence: true, unless: :was_attached?
  # もし外部キーにpresence:trueの制約をかけた場合、バリデーション失敗時のエラーメッセージが「User can’t be blank」となります。
  # 「User must exist」のエラーメッセージを期待するテストを書いている場合、テストを実行した際にエラーが出てしまいます。
  # したがって、外部キーに対して「空ではないか」というpresence: trueのバリデーションを記載しないように注意しましょう。

  def was_attached?
    # 画像があればtrue、なければfalseを返す
    self.image.attached?
  end
end
