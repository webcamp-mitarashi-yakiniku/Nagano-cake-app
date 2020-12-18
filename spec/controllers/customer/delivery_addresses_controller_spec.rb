require 'rails_helper'

RSpec.describe Customer::DeliveryAddressesController, type: :controller do
  # TODO: ログイン時の処理を入れる
  describe "#index" do
    # 認証済みユーザーとして
    context "as an authenticated customer" do
      before do
        # 認証ユーザーのセット
        @customer = FactoryBot.create(:customer)
      end
      # 正常にレスポンスを返すこと
      it "response successfully" do
        sign_in @customer
        get :index
        expect(response).to be_successful
      end
  
      # 200レスポンスを返すこと
      it "returns a 200 response" do
        sign_in @customer
        get :index
        expect(response).to have_http_status "200"
      end
    end

    # ゲストユーザーとして
    context "as a guest" do
      # 320レスポンスを返すこと
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end
      # サインイン画面へのリダイレクトすること
      it "redirects to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end

  end
end