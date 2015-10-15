class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: 200
  end

  def show
    product = Product.find(params[:id])
    render json: product, status: 200
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
    product = Product.find(params[:id])
    if product.update_attributes(product_params)
      render json: product, status: 200
    else
      render json: product.errors, status: 422
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
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
end
