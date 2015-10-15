require 'test_helper'

class ReviewTest < ActionDispatch::IntegrationTest
  test "get request for all reviews of a product returns json data" do
    product = products(:ruby)
    get "/products/#{product.id}/reviews"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    reviews = json(response.body)
    ruby_1 = reviews[:data].detect { |review| review[:attributes][:author] == 'thedude@leboswki.com' }
    assert_equal 4, ruby_1[:attributes][:stars]
  end
end
