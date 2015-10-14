require 'test_helper'

class ProductTest < ActionDispatch::IntegrationTest
  test "get request to '/products' returns json data" do
    get '/products', {}, { Accept: Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    products = JSON.parse(response.body, symbolize_names: true)
    ruby = products[:data].detect { |product| product[:attributes][:name] == 'Ruby' }
    assert_equal 'Red', ruby[:attributes][:color]
  end
end
