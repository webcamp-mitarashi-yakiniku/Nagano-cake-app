require 'rails_helper'

RSpec.describe Customer::HomesController, type: :controller do
  describe "#top" do
    # 正常にレスポンスを返すこと
    it "response successfully" do
      get :top
      expect(response).to be_successful
    end

    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :top
      expect(response).to have_http_status "200"
    end
  end

  describe "#about" do
    # 正常にレスポンスを返すこと
    it "response successfully" do
      get :about
      expect(response).to be_successful
    end

    # 200レスポンスを返すこと
    it "returns a 200 response" do
      get :about
      expect(response).to have_http_status "200"
    end
  end
end