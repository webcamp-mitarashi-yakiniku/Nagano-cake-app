class Customer::UsersController < ApplicationController
  before_action :autheniticate_user, {only: [:edit, :update]}
  # before_action :authenticate_customer!,except: [:top,:about,:index]

  def show

  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to users_path
    else
      render :edit
    end

  end

  def exit

  end

  def destroy
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  def customer_params
    params.require(:customer).permit(:family_name, :first_name, :family_name_kana,
      :first_name_kana,:email, :post_code, :address, :phone_number, :is_active)
  end
end
