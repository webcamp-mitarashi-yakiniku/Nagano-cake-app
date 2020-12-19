require 'rails_helper'

RSpec.describe "Customer::DeliveryAddresses", type: :system do
  # ユーザーは新しい配送先を作成する
  it "creates a new delivery address as a customer" do
    customer = FactoryBot.create(:customer)
    delivery_address = FactoryBot.build(:delivery_address, customer: customer)

    # suppoortの利用でのログイン
    # sign_in_as customer

    # Deviseのヘルパー関数利用でのログイン
    sign_in customer
    visit root_path

    # 表示確認のデバッグ用
    # save_and_open_page
    expect(page).to have_content("Welcome")
    click_link "マイページ"

    # マイページが表示されたことを確認
    expect(page).to have_content("マイページ")

    expect {
      click_link "delivery_index__link"
      expect(page).to have_content "配送先登録"
      fill_in "delivery_post_code__input", with: delivery_address.post_code
      fill_in "delivery_address__input", with: delivery_address.address
      fill_in "delivery_name__input", with: delivery_address.name
      click_button "登録する"

      expect(page).to have_content "配送先登録"
    }.to change(customer.delivery_addresses, :count).by(1)
  end
end
