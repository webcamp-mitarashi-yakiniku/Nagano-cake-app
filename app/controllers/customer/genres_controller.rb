class Customer::GenresController < ApplicationController
  before_action :authenticate_customer!

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @genre_page = @genre.products.page(params[:page]).per(8)
  end

end
