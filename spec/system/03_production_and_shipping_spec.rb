require 'rails_helper'

RSpec.describe "03ProductionAndShipping", type: :system do
  context "管理者のログイン" do
    before :all do
      @customer1 = FactoryBot.create(:customer1)
      @admin1 = FactoryBot.create(:admin1)
      
    end
    it "1_トップ画面が表示される" do
      visit new_admin_session_path
      fill_in "mail_address__input", with: @admin1.email
      fill_in "password__input", with: @admin1.password
      click_button "ログイン"
      expect(page).to have_current_path "/admin"
    end
    it "2_注文履歴一覧画面が表示される" do
      # sign_in @admin1
      visit "/admin"
      click_link "商品一覧"
      expect(page).to have_current_path "/admin/products"
    end
    # it "3_注文詳細画面が表示される" do
    #   visit "/admin/orders"
    #   click_link "商品一覧"
    #   # click_link 
    #   expect(page).to have_current_path （"/admin/products" + @customer1.id.to_s)
    # end
    it "8_管理者ログイン画面に遷移する" do
      sign_in @admin1
      visit "/admin"
      click_link "ログアウト"
      expect(page).to have_current_path "/admin/sign_in"
    end
    after :all do
      Customer.delete_all
      Admin.delete_all
    end
  end

  

end