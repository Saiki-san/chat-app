class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 新規登録時にnameが空欄だった場合、登録できない様に設定。
  # (nameカラムは後付けした為、バリデーション設定が必要)
  validates :name, presence: true
  # ↓emailとpasswordについては、devise生成時の状態で定義済みなので不要
  # validates :email, presence: true
  # validates :password, presence: true
  # validates :password_confirmation, presence: true
  has_many :room_users
  has_many :rooms, through: :room_users
end
