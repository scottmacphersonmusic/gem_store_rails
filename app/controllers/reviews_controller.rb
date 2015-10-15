class ReviewsController < ApplicationController
  def index
    reviews = Review.where(product_id: params[:product_id])
    render json: reviews, status: 200
  end

  def show
    review = Review.find(params[:id])
    render json: review, status: 200
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
    review = Review.find(params[:id])
    if review.update_attributes(review_params)
      render json: review, status: 200
    else
      render json: review.errors, status: 422
    end
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    head 204
  end

  private

  def review_params
    params.require(:review).permit(:stars, :author, :body)
  end
end
