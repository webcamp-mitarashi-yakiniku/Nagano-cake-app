class Customer::ProductsController < ApplicationController
  # before_action :authenticate_user!, only: [:show]

  def index
    @products = Product.all.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @product = Product.find(params[:id])
    @order = Order.new
    @user = current_customer
    
    @genres = Genre.all
    # ジャンルの表示
    
  end
end
