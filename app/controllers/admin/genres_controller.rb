class Admin::GenresController < ApplicationController
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
    genre = Genre.find(params[:id])
    if genre.update(genre_params) then
      redirect_to admin_genres_path
    else
      render :update
    end
  end

  private
  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
