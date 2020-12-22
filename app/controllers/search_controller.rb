class SearchController < ApplicationController

  def locate
    @select_num = params[:option]
    if @select_num == "1"
      @products = Product.search(params[:search]).page(params[:page]).per(10)
    else
      @customers = Customer.search(params[:search]).page(params[:page]).per(10)
    end
  end

end
