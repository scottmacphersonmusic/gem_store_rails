class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :authenticate, except: [:index, :show]

  def index
    products = Product.all
    render json: products, status: 200
  end

  def show
    render json: @product, status: 200
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 201, location: product
    else
      render json: product.errors, status: 422
    end
  end

  def update
    if @product.update_attributes(product_params)
      render json: @product, status: 200
    else
      render json: @product.errors, status: 422
    end
  end

  def destroy
    @product.destroy
    head 204
  end

  private

  def product_params
    params.require(:product)
          .permit(:id,
                  :name,
                  :price,
                  :description,
                  :rarity,
                  :color,
                  :faces)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      User.authenticate(username, password)
    end
  end
end
