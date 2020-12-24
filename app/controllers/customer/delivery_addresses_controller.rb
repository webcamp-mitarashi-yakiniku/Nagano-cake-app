class Customer::DeliveryAddressesController < ApplicationController

  def index
    @delivery_address = DeliveryAddress.new
    @delivery_addresses = current_customer.delivery_addresses
  end

  def create
    # 非同期処理の実行
    @delivery_address = current_customer.delivery_addresses.build(delivery_address_params)
    if @delivery_address.save
      @delivery_addresses = current_customer.delivery_addresses
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
      # TODO: 配送先登録が失敗した場合の処理を記述する
      # curernt_customer.delivery_addressesで取得するとid: nilのレコードも取得されるため工夫が必要
    end
  end

  def edit
    @delivery_address = current_customer.delivery_addresses.find(params[:id])
  end

  def update
    @delivery_address = current_customer.delivery_addresses.find(params[:id])
    if @delivery_address.update(delivery_address_params)
      redirect_to delivery_addresses_path
    else
      render :edit
    end
  end
  
  def destroy
    delivery_address = current_customer.delivery_addresses.find(params[:id])
    delivery_address.destroy
    @delivery_addresses = current_customer.delivery_addresses
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def delivery_address_params
    params.require(:delivery_address).permit(:name, :post_code, :address)
  end

end
