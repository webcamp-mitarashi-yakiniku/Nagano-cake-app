require 'rails_helper'

RSpec.describe Product, type: :model do
  # before do
  #   @genre = Genre(name: "ケーキ", is_active: true)
  # end

  # # バリデーション

  
  # # 文字列に一致するメッセージを検索する
  # describe "search message for a term" do
  #   before do
  #     @product1 = Product.create(
  #       genre: genre,
  #       name: "ホールケーキ",
  #       introduction: "このケーキは",
  #       price: 1980,
  #       on_sale_status: true
  #     )
  #     @product2 = Product.create(
  #       genre: genre,
  #       name: "シフォンケーキ",
  #       introduction: "このケーキは",
  #       price: 1980,
  #       on_sale_status: true
  #     )
  #   end
  #   # 一致するデータが見つかるとき
  #   context "when a match is found" do
  #     # 検索結果に一致する商品を返すこと
  #     it "returns products that match the search term" do
  #     expect(Product.search("ホールケーキ")).to include(@product1)
  #     expect(Product.search("ホールケーキ")).to_not include(@product2)
  #     end
  #   end
  #   # 一致するデータが1件も見つからないとき
  #   context "when no match is found" do
  #     # 検索結果が一件も存在しない場合に空のコレクションを返すこと
  #     it "returns no empty collection when no results are found" do
  #       expect(Product.search("シュークリーム")).to be_empty
  #     end
  #   end
  # end
end
