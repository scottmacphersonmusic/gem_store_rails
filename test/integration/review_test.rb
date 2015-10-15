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
end
