require 'test_helper'

class ReviewTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:ruby)
  end

  test "get request for all reviews of a product returns json data" do
    get "/products/#{@product.id}/reviews"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    reviews = json(response.body)
    ruby_1 = reviews[:data].detect { |review| review[:attributes][:author] == 'thedude@leboswki.com' }
    assert_equal 4, ruby_1[:attributes][:stars]
  end

  test "get request for single product review returns json data" do
    review = reviews(:ruby_1)
    get "/products/#{@product.id}/reviews/#{review.id}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    review = json(response.body)
    assert_equal 'That gem really tied the room together, man',
                 review[:data][:attributes][:body]
  end

  test "post request creates a new product review" do
    post "/products/#{@product.id}/reviews",
         { review: { stars: 1,
                     author: 'diamondjoebiden@aol.com',
                     body: 'Abysmal'} }.to_json,
         { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    review = json(response.body)
    assert_equal 'Abysmal', review[:data][:attributes][:body]
  end

  test "creating a review requires stars, author and body" do
    post "/products/#{@product.id}/reviews/",
         { review: { stars: nil,
                     author: nil,
                     body: nil } }.to_json,
         { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type


    errors = json(response.body)
    assert_equal "can't be blank", errors[:stars][0]
    assert_equal "can't be blank", errors[:author][0]
    assert_equal "can't be blank", errors[:body][0]
  end
end
