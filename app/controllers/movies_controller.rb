# typed: false
# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @movies = Movie.send(movies_filter)
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    if signed_in_user
      @favorite = signed_in_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to(@movie, notice: "Movie successfully created!")
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    if @movie.update(movie_params)
      redirect_to(@movie, notice: "Movie successfully updated!")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def destroy
    @movie.destroy
    redirect_to(
      movies_url,
      status: :see_other,
      alert: "Movie successfully deleted!",
    )
  end

  def new
    @movie = Movie.new
  end

  private

  def movie_params
    params.require(:movie)
      .permit(
        :title,
        :description,
        :rating,
        :released_on,
        :total_gross,
        :director,
        :duration,
        :main_image,
        genre_ids: [],
      )
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:id])
  end

  def movies_filter
    if params[:filter].in?(["upcoming", "recent", "hits", "flops"])
      params[:filter]
    else
      :released
    end
  end
end
