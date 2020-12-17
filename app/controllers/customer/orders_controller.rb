class Customer::OrdersController < ApplicationController
  def new
    @delivery_addresses = DeliveryAddress.where(customer_id: current_customer.id)
    @new_delivery_addresses = DeliveryAddress.new
    @order = Order.new
  end

  def confirm
    @order = Order.create(order_params)
    @order.customer_id = current_customer.id
    @order.shipping = 800
    @cart_products = CartProduct.where(customer_id: current_customer.id)
    @order.account = get_total(@cart_products) + @order.shipping

    # 選択されたお届け先を格納する
    case params[:order][:send_address]
    when "0" then
      # 顧客の住所が選択された場合
      @order.name = get_fullname(current_customer)
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address

    when "1" then
      # 登録済住所が選択された場合
      delivery_address = DeliveryAddress.find(params[:registered_address])
      @order.name = delivery_address.name
      @order.post_code = delivery_address.post_code
      @order.address = delivery_address.address
    else
      # 新しいお届け先が選択された場合
      # 新しいお届け先の保存も行う
      new_delivery_address = DeliveryAddress.new
      new_delivery_address.customer_id = current_customer.id
      new_delivery_address.name = params[:order][:new_name]
      new_delivery_address.post_code = params[:order][:new_post_code]
      new_delivery_address.address = params[:order][:new_address]
      @order.name = new_delivery_address.name
      @order.post_code = new_delivery_address.post_code
      @order.address = new_delivery_address.address
    end

  end

  def thanks
    order = Order.create(order_params)
    order.save
  end

  private
  # ストロングパラメータ
  def order_params
    params.require(:order).permit(:customer_id, :name, :post_code, :address, :account, :shipping, :payment_method, :order_status)
  end

  # フルネームを取得
  def get_fullname(customer)
    customer.family_name + customer.first_name
  end

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
    tmp = Product.find(cart_product.product_id).price * 1.1
    tmp = BigDecimal((tmp).to_s).ceil # 小数点切り上げ
  end
end
