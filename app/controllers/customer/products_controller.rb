class Customer::ProductsController < ApplicationController
  # before_action :authenticate_user!, only: [:show]

  def index
    @products = Product.all
    @products_page = @products.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @order = Order.new
    @customer = current_customer
    @genres = Genre.all
    # ジャンルの表示
    @cart_product = CartProduct.new
  end
end
