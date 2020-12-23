class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    # TODO: ページネーションで何件デフォルトで表示するかは要検討
    @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products
  end

  def update
    order = Order.find(params[:id])
    # TODO: strong parameterで変数を取得し更新する処理も考慮する
    order.update_attributes(order_status: params[:order_status])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
