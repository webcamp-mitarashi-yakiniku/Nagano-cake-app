require 'rails_helper'

RSpec.describe Customer::UsersController, type: :controller do
  # TODO: ログイン時の処理を入れる
  describe "#show" do
    # 正常にレスポンスを返すこと
    it "response successfully" do
      get :show
      expect(response).to be_successful
    end
  end
end