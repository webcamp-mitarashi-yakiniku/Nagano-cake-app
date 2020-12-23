class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  # before_action :admin_logged_in?

  def index
    @new_genre = Genre.new
    @genres = Genre.all
  end

  def create
    genre = Genre.create(genre_params)
    genre.save
    @genres = Genre.all
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
