class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    # TODO: デフォルトで何件表示するかは要検討
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_user_path(@customer)
    else
      render :edit
    end
  end

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana, :first_name_kana,
                  :post_code, :address, :phone_number, :email, :is_active)
  end

end
