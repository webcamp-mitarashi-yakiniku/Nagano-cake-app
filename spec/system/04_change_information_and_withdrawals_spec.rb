require 'rails_helper'

RSpec.describe "04ChangeInformationAndWithdrawals", type: :system do

  context "登録済住所への注文" do
    before :all do
      @customer1 = FactoryBot.create(:customer1)
      @product1 = FactoryBot.create(:product1)
    end
    it "1_会員情報編集画面に遷移する" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      expect(page).to have_current_path "/users/edit"
    end
    it "2_マイページに遷移する" do
      sign_in @customer1
      visit "/users/edit"
      fill_in "family_name__input", with: "鈴木"
      fill_in "first_name__input", with: "次郎"
      fill_in "family_name_kana__input", with: "スズキ"
      fill_in "first_name_kana__input", with: "ジロウ"
      fill_in "mail_address__input", with: "suzuki.jiro@gmail.com"
      fill_in "post_code__input", with: "2060031"
      fill_in "address__input", with: "東京都多摩市1-1-1"
      fill_in "phone_number__input", with: "08011112222"
      click_button "編集内容を保存する"
      expect(page).to have_current_path "/users"
    end
    it "3_変更した内容が表示される" do
      sign_in @customer1
      visit "/users/edit"
      fill_in "family_name__input", with: "鈴木"
      fill_in "first_name__input", with: "次郎"
      fill_in "family_name_kana__input", with: "スズキ"
      fill_in "first_name_kana__input", with: "ジロウ"
      fill_in "mail_address__input", with: "suzuki.jiro@gmail.com"
      fill_in "post_code__input", with: "2060031"
      fill_in "address__input", with: "東京都多摩市1-1-1"
      fill_in "phone_number__input", with: "08011112222"
      click_button "編集内容を保存する"
      expect(page).to have_content "鈴木"
      expect(page).to have_content "次郎"
      expect(page).to have_content "スズキ"
      expect(page).to have_content "ジロウ"
      expect(page).to have_content "suzuki.jiro@gmail.com"
      expect(page).to have_content "2060031"
      expect(page).to have_content "東京都多摩市1-1-1"
      expect(page).to have_content "08011112222"
    end
    it "4_配送先一覧画面に遷移する" do
      sign_in @customer1
      visit "/users"
      find("#delivery_addresses_index").click
      expect(page).to have_current_path "/delivery_addresses"
    end
    it "5_自画面が再描画される" do
      sign_in @customer1
      visit "/delivery_addresses"
      fill_in "delivery_post_code__input", with: "1002100"
      fill_in "delivery_address__input", with: "東京都小笠原村沖ノ鳥島 1番地"
      fill_in "delivery_name__input", with: "沖ノ鳥島灯台"
      click_button "登録する"
      expect(page).to have_current_path "/delivery_addresses"
    end
    it "6_登録した内容が表示されている" do
      sign_in @customer1
      visit "/delivery_addresses"
      fill_in "delivery_post_code__input", with: "1002100"
      fill_in "delivery_address__input", with: "東京都小笠原村沖ノ鳥島 1番地"
      fill_in "delivery_name__input", with: "沖ノ鳥島灯台"
      click_button "登録する"
      expect(page).to have_content "1002100"
      expect(page).to have_content "東京都小笠原村沖ノ鳥島 1番地"
      expect(page).to have_content "沖ノ鳥島灯台"
    end
    it "7_トップ画面が表示される" do
      sign_in @customer1
      visit "/delivery_addresses"
      click_on 'ヘッダーロゴ'
      expect(page).to have_current_path "/"
    end
    it "8_該当商品の詳細画面に遷移する" do
      sign_in @customer1
      visit root_path
      click_on @product1.name
      expect(page).to have_current_path ("/products/" + @product1.id.to_s)
    end
    it "9_商品情報が正しく表示されている" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      expect(page).to have_content "ロールケーキ"
      expect(page).to have_content "おいしい"
      expect(page).to have_content "¥100"
      expect(page).to have_selector("img[src$='jpeg']")
    end
    it "10_カート画面に遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      expect(page).to have_current_path "/cart_products"
    end
    it "11_カートの中身が正しく表示されている" do
      # カート内商品はitごとにクリアされるため、都度、同じ手順を踏む必要がある
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      expect(page).to have_content "ロールケーキ"
      expect(page).to have_content "550"
    end
    it "12_情報入力画面に遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      expect(page).to have_current_path "/orders/new"
    end
    it "13_先ほど登録した住所が選択できるようになっている" do
      # 登録した住所はitごとにクリアされるため、再度、登録する必要がある
      sign_in @customer1
      visit "/delivery_addresses"
      fill_in "delivery_post_code__input", with: "1002100"
      fill_in "delivery_address__input", with: "東京都小笠原村沖ノ鳥島 1番地"
      fill_in "delivery_name__input", with: "沖ノ鳥島灯台"
      click_button "登録する"
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      expect(page).to have_content "1002100 東京都小笠原村沖ノ鳥島 1番地 沖ノ鳥島灯台"
    end
    it "14_注文情報確認画面に遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      click_button "確認画面へ進む"
      expect(page).to have_current_path "/orders/confirm"
    end
    it "14.1_サンクスページに遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      expect(page).to have_current_path "/orders/thanks", ignore_query: true
    end
    it "15_トップ画面が表示される" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      click_on 'ヘッダーロゴ'
      expect(page).to have_current_path "/"
    end
    after :all do
      Customer.delete_all
      Product.delete_all
    end
  end

  context "新規住所への注文" do
    before :all do
      @customer1 = FactoryBot.create(:customer1)
      @product1 = FactoryBot.create(:product1)
    end
    # 他の試験と同じなので省略
    # it "16_該当商品の詳細画面に遷移する" do
    # end
    # it "17_商品情報が正しく表示されている" do
    # end
    # it "18_カート画面に遷移する" do
    # end
    # it "19_カートの中身が正しく表示されている" do
    # end
    # it "20_情報入力画面に遷移する" do
    # end
    # it "21_-" do
    # end
    it "22_注文確認画面に遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      expect(page).to have_current_path "/orders/confirm"
    end
    it "23_選択した商品、合計金額、配送方法などが表示されている" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      expect(page).to have_content "ロールケーキ"
      expect(page).to have_content "550"
      expect(page).to have_content "800"
      expect(page).to have_content "1,350"
      expect(page).to have_content "クレジットカード"
      expect(page).to have_content "北海道稚内市"
      expect(page).to have_content "宗谷岬"
    end
    it "24_サンクスページに遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      expect(page).to have_current_path "/orders/thanks", ignore_query: true
    end
    it "25_マイページに遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      click_link "マイページ"
      expect(page).to have_current_path "/users"
    end
    it "26_配送先一覧画面に遷移する" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      click_link "マイページ"
      find("#delivery_addresses_index").click
      expect(page).to have_current_path "/delivery_addresses"
    end
    it "27_先ほど購入時に入力した住所が表示されている" do
      sign_in @customer1
      visit ("/products/" + @product1.id.to_s)
      select "5", :from => "cart_product[product_quantity]"
      click_button "カートに入れる"
      click_link "情報入力に進む"
      choose "radio_button_send_address_2"
      fill_in "order_new_post_code", with: "0986758"
      fill_in "order_new_address", with: "北海道稚内市"
      fill_in "order_new_name", with: "宗谷岬"
      click_button "確認画面へ進む"
      click_button "購入を確定する"
      click_link "マイページ"
      find("#delivery_addresses_index").click
      expect(page).to have_content "0986758"
      expect(page).to have_content "北海道稚内市"
      expect(page).to have_content "宗谷岬"
    end
    # 他の試験と同じなので省略
    # it "28_マイページに戻る" do
    # end
    after :all do
      Customer.delete_all
      Product.delete_all
    end
  end

  context "退会処理" do
    before :each do
      @customer1 = FactoryBot.create(:customer1)
      @admin1 = FactoryBot.create(:admin1)
    end
    # 他の試験と同じなので省略
    # it "29_会員情報編集画面が表示される" do
    # end
    it "30_アラートが表示される" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      expect(page).to have_content "本当に退会しますか？"
    end
    it "31_トップ画面に遷移する" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      expect(page).to have_current_path "/"
    end
    it "32_ヘッダが未ログイン状態になっている" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      expect(page).to have_content "ログイン"
    end
    it "33_ログイン画面に遷移する" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      click_link "ログイン"
      expect(page).to have_current_path "/sign_in"
    end
    it "34_ログインが不可" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      click_link "ログイン"
      fill_in "session_email", with: @customer1.email
      fill_in "session_password", with: @customer1.password
      click_button "ログイン"
      expect(page).to have_current_path "/sign_in"
    end
    it "35_管理者トップ画面が表示される" do
      visit new_admin_session_path
      fill_in "mail_address__input", with: @admin1.email
      fill_in "password__input", with: @admin1.password
      click_button "ログイン"
      expect(page).to have_current_path "/admin"
    end
    it "36_会員一覧画面が表示される" do
      sign_in @admin1
      visit "/admin"
      click_link "会員一覧"
      expect(page).to have_current_path "/admin/users"
    end
    it "37_先ほど退会したユーザが「退会済」になっている" do
      sign_in @customer1
      visit root_path
      click_link "マイページ"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      sign_in @admin1
      visit "/admin"
      click_link "会員一覧"
      tds = page.all("td")
      expect(tds[3]).to have_content "無効"
    end
    it "38_会員情報詳細画面に遷移する" do
      sign_in @admin1
      visit "/admin"
      click_link "会員一覧"
      click_link @customer1.family_name + @customer1.first_name
      expect(page).to have_current_path ("/admin/users/" + @customer1.id.to_s)
    end
    it "39_変更した住所が表示されている" do
      # 顧客側の動作
      # 住所変更 & 退会
      sign_in @customer1
      visit "/users/edit"
      fill_in "family_name__input", with: "鈴木"
      fill_in "first_name__input", with: "次郎"
      fill_in "family_name_kana__input", with: "スズキ"
      fill_in "first_name_kana__input", with: "ジロウ"
      fill_in "mail_address__input", with: "suzuki.jiro@gmail.com"
      fill_in "post_code__input", with: "2060031"
      fill_in "address__input", with: "東京都多摩市1-1-1"
      fill_in "phone_number__input", with: "08011112222"
      click_button "編集内容を保存する"
      click_link "編集する"
      click_link "退会する"
      click_link "退会する"
      # 管理者側の動作
      sign_in @admin1
      visit "/admin"
      click_link "会員一覧"
      click_link "鈴木次郎"
      expect(page).to have_content "鈴木  次郎"
      expect(page).to have_content "スズキ  ジロウ"
      expect(page).to have_content "2060031"
      expect(page).to have_content "東京都多摩市1-1-1"
      expect(page).to have_content "08011112222"
      expect(page).to have_content "suzuki.jiro@gmail.com"
    end
    it "40_ログイン画面が表示される" do
      sign_in @admin1
      visit "/admin"
      click_link "ログアウト"
      expect(page).to have_current_path "/admin/sign_in"
    end
  end

  after :all do
    Customer.delete_all
  end
end
