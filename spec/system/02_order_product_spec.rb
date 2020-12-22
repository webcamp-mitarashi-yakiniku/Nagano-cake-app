########################
# テスト仕様書           #
#  ②登録〜注文          #
########################
require 'rails_helper'


RSpec.describe "02OrderProduct", type: :system do

  # ゲストユーザーのテスト
  context "ゲストユーザーのテスト" do
    # factory_botから使用するモデルを遅延評価letで定義(before doで定義してもよい)
    let(:customer) { FactoryBot.build(:customer1) }
    # before do
    #   @customer = FactoryBot.build(:customer)
    # end

    # トップページから新規登録画面を表示する
    it "トップページから新規登録画面を表示する" do
      visit root_path
      click_link "新規登録"
      # 新規登録画面の表示を確認する
      expect(page).to have_content("新規会員登録")
    end

    # 新規登録画面に必要事項を入力してトップ画面に遷移する
    it "新規登録画面から登録しトップ画面に遷移する" do
      visit new_customer_registration_path
      # フォームのidを指定して入力する
      fill_in "family_name__input", with: customer.family_name
      fill_in "first_name__input", with: customer.first_name
      fill_in "family_name_kana__input", with: customer.family_name_kana
      fill_in "first_name_kana__input", with: customer.first_name_kana
      fill_in "mail_address__input", with: customer.email
      fill_in "post_code__input", with: customer.post_code
      fill_in "address__input", with: customer.address
      fill_in "phone_number__input", with: customer.phone_number
      fill_in "password__input", with: customer.password
      fill_in "password_confirmation__input", with: customer.password
      click_button "送信する"
      # save_and_open_page
      # トップ画面への遷移を確認
      expect(page).to have_current_path(root_path)
      # ヘッダーがログイン後に変更されていることを確認
      expect(page).to have_content("マイページ")
      expect(page).to have_content("商品一覧")
      expect(page).to have_content("カート")
      expect(page).to have_content("ログアウト")
      # ログイン後に表示されないヘッダーを確認
      expect(page).to_not have_content("About")
      expect(page).to_not have_content("新規登録")
      expect(page).to_not have_content("ログイン")
    end
  end

  # 認証ユーザーのテスト
  context "認証されたユーザーのテスト" do
    # ユーザーのDB登録
    before do
      @customer = FactoryBot.create(:customer1)
      @product = FactoryBot.create(:product1)
    end

    # トップページの商品画像を押下して商品詳細画面に遷移する
    it "トップページの商品画像を押下し詳細画面に遷移する" do
      # Deviseでログイン処理
      sign_in @customer
      visit root_path
      # 画像をクリックする
      click_on @product.name
      expect(page).to have_current_path(("/products/" + @product.id.to_s))
      # カートの中身が正しく表示されている
      expect(page).to have_content @product.name
      expect(page).to have_content @product.introduction
      expect(page).to have_content @product.price
    end

    it "個数を選択しカートに入れ買い物を続けるボタンを押下するとトップ画面に遷移する", focus: true do
      sign_in @customer
      visit product_path(@product)
      # 商品詳細ページの表示確認
      expect(page).to have_content(@product.name)
      select "1", from: 'cart_product[product_quantity]'
      click_button "カートに入れる"
      # カート画面に遷移することを確認
      expect(page).to have_content("ショッピングカート")
      # 選択した商品がカートに追加されていることを確認
      expect(find("#cart_products_table")).to have_content(@product.name)
      click_link "買い物を続ける"
      # トップページへの遷移を確認
      expect(page).to have_current_path(root_path)
    end

    it "個数を選択しカートに入れた商品を注文する", js: true do
      sign_in @customer
      visit product_path(@product)
      # 商品詳細ページの表示確認
      expect(page).to have_content(@product.name)
      select "1", from: 'cart_product[product_quantity]'
      click_button "カートに入れる"
      # カート画面に遷移することを確認
      expect(page).to have_content("ショッピングカート")
      # 選択した商品がカートに追加されていることを確認
      expect(find("#cart_products_table")).to have_content(@product.name)
      # 商品の個数を変更し更新ボタンを押下する
      fill_in 'product_quantity__input', with: "5"
      click_button '変更'
      click_link '情報入力に進む'
      expect(page).to have_current_path(new_order_path)
    end
  end
end