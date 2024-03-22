# typed: false
# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    @movie.favorites.create!(user: signed_in_user)

    # or append to the through association
    # @movie.fans << signed_in_user

    redirect_to(@movie)
  end

  def destroy
    favorite = signed_in_user.favorites.find(params[:id])
    favorite.destroy

    redirect_to(@movie)
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
