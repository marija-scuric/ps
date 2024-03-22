# typed: false
# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :require_signin
  before_action :set_movie
  before_action :set_review, only: [:edit, :update, :destroy, :show]

  def index
    @reviews = @movie.reviews
  end

  def new
    @review = @movie.reviews.new
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to(movie_review_path(@movie, @review), notice: "Review successfully updated!")
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  def create
    @review = @movie.reviews.new(review_params)
    @review.user = signed_in_user
    if @review.save
      redirect_to(
        movie_reviews_path(@movie),
        notice: "Thanks for your review!",
      )
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def destroy
    @review.destroy
    redirect_to(
      movie_reviews_path(@movie),
      status: :see_other,
      alert: "Review successfully deleted!",
    )
  end

  def show
  end

  private

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:comment, :stars)
  end

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
