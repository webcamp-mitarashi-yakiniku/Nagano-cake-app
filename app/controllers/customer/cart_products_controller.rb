class Customer::CartProductsController < ApplicationController
  before_action :authenticate_customer!

  def create
    cart_product = CartProduct.create(cart_product_params)
    cart_product.customer_id = current_customer.id
    if cart_product.save
      redirect_to cart_products_url
    else
      flash[:notice] = "注文個数を選択してください"
      redirect_to product_path(params[:cart_product][:product_id])
    end
  end

  def index
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def update
    cart_product = CartProduct.find(params[:id])
    cart_product.update(cart_product_params)
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  def destroy
    cart_product = CartProduct.find(params[:id])
    cart_product.delete
    @cart_products = CartProduct.where(customer_id: current_customer.id)
  end

  # カートの中身を全て空にする
  def empty
    # @cart_products = CartProduct.where(customer_id: current_customer.id)
    @cart_products = current_customer.cart_products
    # 全データを削除
    @cart_products.each do |cart_product|
      cart_product.delete
    end
    # カートの中身を再取得。中身は空になっている
    @cart_products = current_customer.cart_products
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:product_id, :product_quantity)
  end

end
