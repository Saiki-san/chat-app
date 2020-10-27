FactoryBot.define do
  factory :room_user do
    # associationメソッド：FactoryBotによって生成されるモデルを関連づけるメソッド
    association :user
    association :room
  end
end