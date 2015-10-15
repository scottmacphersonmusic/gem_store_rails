class ReviewsController < ApplicationController
  def index
    reviews = Review.where(product_id: params[:product_id])
    render json: reviews, status: 200
  end

  def show
    review = Review.find(params[:id])
    render json: review, status: 200
  end
end
