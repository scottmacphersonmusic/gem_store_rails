class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

  def index
    reviews = Review.where(product_id: params[:product_id])
    render json: reviews, status: 200
  end

  def show
    render json: @review, status: 200
  end

  def create
    product = Product.find(params[:product_id])
    review = product.reviews.build(review_params)
    if review.save
      render json: review, status: 201
    else
      render json: review.errors, status: 422
    end
  end

  def update
    if @review.update_attributes(review_params)
      render json: @review, status: 200
    else
      render json: @review.errors, status: 422
    end
  end

  def destroy
    @review.destroy
    head 204
  end

  private

  def review_params
    params.require(:review).permit(:stars, :author, :body)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
