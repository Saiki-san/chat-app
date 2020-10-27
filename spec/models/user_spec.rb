require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      # expect(X).to eq Y:「Xの結果はYになる」ということを確認。eqは、等しい（イコール）を意味するとイメージ（厳密には異なる）
      # be_valid：expectのインスタンスが正しく保存されることを判断します。expect(インスタンス).to be_validのように使用。最後に?が付かないことに注意！
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      # @user.nameの中身を空に
      @user.name = nil
      # .valid?で、@userが正しく保存されるているかどうか確認(バリデーションをかけているので、falseのはず)。最後に?が必要！
      @user.valid?
      # ↓後のinclude("")で指定するエラーメッセージを確認する際は、この列でbinding.pryをかけて、
      # コンソールで(「@user.valid?」と「@user.errors」+)「@user.errors.full_messages」と入力
      # binding.pry
      # もしDBに保存されない場合のエラーメッセージは、「Name can't be blank（訳：nameを入力してください）」となっているか確認。
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "123456"
      @user.password_confirmation = "123456"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "12345"
      @user.password_confirmation = "12345"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = "1234567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      # FactoryBotを用いて、user情報（name、email、password、password_confirmation）の中でも「email」だけを選択してインスタンスを生成
      # 生成したインスタンスを「another_user」に代入
      another_user = FactoryBot.build(:user, email: @user.email)
      # もし保存しようとしているemailが既にDBに存在している場合、
      # 「Email has already been taken（そのEmailは既に使われています）」というエラー文が表示(されることを確認)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
