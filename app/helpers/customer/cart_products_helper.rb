module Customer::CartProductsHelper
  # カート内商品の合計金額を取得
  def get_total(cart_products)
    total = 0
    cart_products.each do |cart_product|
      total = total + get_subtotal(cart_product)
    end
    return total
  end

  # カート内商品の小計を取得
  def get_subtotal(cart_product)
    tmp = get_price_including_tax(cart_product)
    tmp * cart_product.product_quantity
  end

  # カート内商品の税込み価格を取得
  def get_price_including_tax(cart_product)
    tmp = BigDecimal((Product.find(cart_product.product_id).price).to_s) * BigDecimal("1.1")
    tmp = BigDecimal((tmp).to_s).ceil # 小数点切り上げ
  end

end
