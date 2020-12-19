require 'rails_helper'

RSpec.describe Customer::DeliveryAddressesController, type: :controller do

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
    # context "as a guest" do
    #   # 320レスポンスを返すこと
    #   it "returns a 302 response" do
    #     get :index
    #     expect(response).to have_http_status "302"
    #   end
    #   # サインイン画面へのリダイレクトすること
    #   it "redirects to the sign-in page" do
    #     get :index
    #     expect(response).to redirect_to "/users/sign_in"
    #   end
    # end
  end

  # describe "#show" do
  #   # 認証済みユーザーとして
  #   context "as an authenticated customer" do
  #     before do
  #       @customer = FactoryBot.create(:customer)
  #       @delivery_address = FactoryBot.create(:delivery_address, customer: @customer)
  #     end
  #     # 正常にレスポンスを返すこと
  #     it "response successfully" do
  #       sign_in @customer
  #       get :show, params: { id: @delivery_address.id }
  #       expect(response).to be_successful
  #     end
  #     # 200レスポンスを返すこと
  #     it "returns a 200 response" do
  #       sign_in @customer
  #       get :show, params: { id: @delivery_address.id }
  #       expect(response).to have_http_status "200"
  #     end
  #   end
  #   # 許可されていないユーザーとして（他のユーザーが見れないようにする）
  #   context "as a guest" do
  #     before do
  #       @customer = FactoryBot.create(:customer)
  #       other_customer = FactoryBot.create(:customer)
  #       @delivery_address = FactoryBot.create(:delivery_address, customer: other_customer)
  #     end
  #     # 320レスポンスを返すこと
  #     it "returns a 302 response" do
  #       get :index
  #       expect(response).to have_http_status "302"
  #     end
  #     # サインイン画面へのリダイレクトすること
  #     it "redirects to the sign-in page" do
  #       sign_in @customer
  #       get :show, params: { id: @delivery_address.id }
  #       expect(response).to redirect_to "/users/sign_in"
  #     end
  #   end
  # end

  describe "#create" do
    # 認証済みユーザーとして
    context "as an authenticated user" do
      before do
        @customer = FactoryBot.create(:customer)
      end

      # 有効な属性値の場合
      context "with valid attributes" do
        # 配送先を追加できること
        it "add a delivery address" do
          delivery_address_params = FactoryBot.attributes_for(:delivery_address)
          sign_in @customer
          expect {
            post :create, params: { delivery_address: delivery_address_params }
          }.to change(@customer.delivery_addresses, :count).by(1)
        end
      end

      # 無効な属性値の場合
      context "with invalid attributes" do
        # 配送先を追加できないこと
        it "does not add a delivery address" do
          delivery_address_params = FactoryBot.attributes_for(:delivery_address,:invalid)
          sign_in @customer
          expect {
            post :create, params: { delivery_address: delivery_address_params }
          }.to_not change(@customer.delivery_addresses, :count)
        end
      end
    end


    # ゲストとして
    # context "as a guest" do
    #   # 302レスポンスを返すこと
    #   it "returns a 302 response" do
    #     delivery_address_params = FactoryBot.attributes_for(:delivery_address)
    #     post :create, params: { delivery_address: delivery_address_params }
    #     expect(response).to redirect_to "/users/sign_in"
    #   end
    # end
  end

  describe "#update" do
    # 許可されたユーザーとして
    context "as an authorized user" do
      before do
        @customer = FactoryBot.create(:customer)
        @delivery_address = FactoryBot.create(:delivery_address, customer: @customer)
      end

      # プロジェクトを更新できること
      it "updates a project" do
        delivery_address_params = FactoryBot.attributes_for(:delivery_address, name: "山本様")
        sign_in @customer
        patch :update, params: { id: @delivery_address.id, delivery_address: delivery_address_params }
        expect(@delivery_address.reload.name).to eq "山本様"
      end
    end

    # 許可されていないユーザーとして
    # context "as an unathorized user" do
    #   before do
    #     @customer = FactoryBot.create(:customer)
    #     other_customer = FactoryBot.create(:customer)
    #     @delivery_address = FactoryBot.create(:delivery_address, customer: other_customer, name: "家森様")
    #   end

    #   # 配送先を更新できないこと
    #   it "does not update the delivery address" do
    #     delivery_address_params = FactoryBot.attributes_for(:delivery_address, name: "山本様")
    #     sign_in @customer
    #     patch :update, params: { id: @delivery_address.id, delivery_address: delivery_address_params }
    #     expect(@delivery_address.reload.name).to eq "家森様"
    #   end

    #   # トップページへのリダイレクト処理
    #   it "redirects to the top" do
    #     delivery_address_params = FactoryBot.attributes_for(:delivery_address)
    #     sign_in @customer
    #     patch :update, params: { id: @delivery_address.id }
    #     expect(response).to redirect_to root_path
    #   end
    # end

    # ゲストとして
    # context "as a guest" do
    #   before do
    #     @delivery_address = FactoryBot.create(:delivery_address)
    #   end

    #   # 302レスポンスを返すこと
    #   it "returns a 302 response" do
    #     delivery_address_params = FactoryBot.attributes_for(:delivery_address)
    #     patch :update, params: { id: @delivery_address.id, delivery_address: delivery_address_params }
    #     expect(response).to have_http_status "302"
    #   end

    #   # サインイン画面にリダイレクトすること
    #   it "redirects to the sign-in page" do
    #     delivery_address_params = FactoryBot.attributes_for(:delivery_address)
    #     patch :update, params: { id: @delivery_address.id, delivery_address: delivery_address_params }
    #     expect(response).to redirect_to "/users/sign_in"
    #   end
    # end
  end

  describe "#destroy" do
    # 許可されたユーザーとして
    context "as an authorized user" do
      before do
        @customer = FactoryBot.create(:customer)
        @delivery_address = FactoryBot.create(:delivery_address, customer: @customer)
      end

      # 配送先を削除できること
      it "deletes a delivery address" do
        sign_in @customer
        expect {
          delete :destroy, params: { id: @delivery_address.id }
        }.to change(@customer.delivery_addresses, :count).by(-1)
      end
    end

    # 許可されていないユーザーとして
    # context "as an unauthorized user" do
    #   before do
    #     @customer = FactoryBot.create(:customer)
    #     other_customer = FactoryBot.create(:customer)
    #     @delivery_address = FactoryBot.create(:delivery_address, customer: other_customer)
    #   end

    #   # 配送先を削除できないこと
    #   it "does not delete the delivery address" do
    #     sign_in @customer
    #     expect {
    #       delete :destroy, params: { id: @delivery_address.id }
    #     }.to_not change(DeliveryAddress, :count)
    #   end

    #   # トップページにリダイレクトすること
    #   it "redirects to the top" do
    #     sign_in @customer
    #     delete :destory, params: { id: @delivery_address.id }
    #     expect(response).to redirect_to root_path
    #   end
    # end

    # ゲストとして
    # context "as a guest" do
    #   before do
    #     @delivery_address = FactoryBot.create(:delivery_address)
    #   end
    #   # 302レスポンスを返すこと
    #   it "returns a 302 response" do
    #     delete :destroy, params: { id: @delivery_address.id }
    #     expect(response).to have_http_status "302"
    #   end

    #   # サインイン画面にリダイレクトすること
    #   it "redirects to the sign-in page" do
    #     delete :destroy, params: { id: @delivery_address.id }
    #     expect(response).to redirect_to "/users/sign_in"
    #   end

    #   # プロジェクトを削除できないこと
    #   it "does not delete the project" do
    #     expect {
    #       delete :destroy, params: { id: @delivery_address.id }
    #     }.to_not change(DeliveryAddress, :count)
    #   end
    # end
  end
end