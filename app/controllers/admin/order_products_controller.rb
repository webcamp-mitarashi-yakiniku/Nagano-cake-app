class Admin::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  def update
    order_product = OrderProduct.find(params[:id])
    # TODO: strong parameterで変数を取得し更新する処理も考慮する
    order_product.update_attributes(work_status: params[:work_status])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
