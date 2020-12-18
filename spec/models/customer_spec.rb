require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    # @customer = Customer.new(
    #   first_name: "一郎",
    #   family_name: "田中",
    #   first_name_kana: "イチロウ",
    #   family_name_kana: "タナカ",
    #   email: "tanaka@gmail.com",
    #   password: "tanakatanaka",
    #   post_code: "8970008",
    #   address: "東京都世田谷区駒沢3-1-1",
    #   phone_number: "09087904563"
    # )
  end

  describe "is created" do
    # Customerが正常に作成される場合
    context "to be valid" do
      # 姓、名、メール、パスワードがあれば有効な状態にあること
      it "first name(kana), family name(kana), email, password, post code, address, phone number" do
        # expect(@customer).to be_valid
        expect(build(:customer)).to be_valid
      end
    end

    # Customerが正常に作成されない場合
    context "to be invalid" do
      # 名がなければ無効な状態にあること
      it "without a first name" do
        # customer = Customer.new(first_name: nil)
        customer = build(:customer, first_name: nil)
        customer.valid?
        expect(customer.errors[:first_name]).to include("can't be blank")
      end
      # 姓がなければ無効な状態にあること
      it "without a last name" do
        # customer = Customer.new(family_name: nil)
        customer = build(:customer, family_name: nil)
        customer.valid?
        expect(customer.errors[:family_name]).to include("can't be blank")
      end
      # セイがなければ無効な状態にあること
      it "without a family name(kana)" do
        # customer = Customer.new(family_name_kana: nil)
        customer = build(:customer, family_name_kana: nil)
        customer.valid?
        expect(customer.errors[:family_name_kana]).to include("can't be blank")
      end
      # メイがなければ無効な状態にあること
      it "without a first name(kana)" do
        # customer = Customer.new(first_name_kana: nil)
        customer = build(:customer, first_name_kana: nil)
        customer.valid?
        expect(customer.errors[:first_name_kana]).to include("can't be blank")
      end
      # メールアドレスがなければ無効な状態であること
      it "without an email address" do
        # customer = Customer.new(email: nil)
        customer = build(:customer, email: nil)
        customer.valid?
        expect(customer.errors[:email]).to include("can't be blank")
      end
      # 重複したメールアドレスなら無効な状態にあること
      it "with a duplicate email address" do
        FactoryBot.create(:customer, email: "test@gmail.com")
        customer = FactoryBot.build(:customer, email: "test@gmail.com")
        customer.valid?
        expect(customer.errors[:email]).to include("has already been taken")
      end
      # 郵便番号がなければ無効な状態であること
      it "without a post code" do
        # customer = Customer.new(post_code: nil)
        customer = build(:customer, post_code: nil)
        customer.valid?
        expect(customer.errors[:post_code]).to include("can't be blank")
      end
      # 住所がなければ無効な状態であること
      it "without a addres" do
        customer = build(:customer, address: nil)
        customer.valid?
        expect(customer.errors[:address]).to include("can't be blank")
      end
      # 電話番号がなければ無効な状態であること
      it "without a post code" do
        customer = build(:customer, phone_number: nil)
        customer.valid?
        expect(customer.errors[:phone_number]).to include("can't be blank")
      end
      # emailアドレスが正しいフォーマットでないため無効な状態にあること
      it "without a family name" do
        customer = build(:customer, email: "tanaka.gmail.com")
        customer.valid?
        expect(customer.errors[:email]).to include("正しいフォーマットを入力してください。")
      end
    end
  end

  # 関数のテスト
  describe "has functions" do
    # ユーザーのフルネームを文字列として返すこと
    it "returns a user's full name as a string" do
      customer = build(:customer, first_name: "一郎", family_name: "田中")
      expect(customer.full_name).to eq "田中一郎"
    end
  end
end
