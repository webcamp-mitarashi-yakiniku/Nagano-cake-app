class Customer::HomesController < ApplicationController
  def top
    # 最新の8つ分のデータをおすすめ商品として表示
    @products = Product.last(8)
    @genres = Genre.all
  end

  def about
  end
end
