require 'test_helper'

class ProductTest < ActionDispatch::IntegrationTest
  test "get request for all products returns json data" do
    get '/products', {}, { Accept: Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    products = json(response.body)
    ruby = products[:data].detect { |product| product[:attributes][:name] == 'Ruby' }
    assert_equal 'Red', ruby[:attributes][:color]
  end

  test "get request for single product returns json data" do
    get '/products/720244849', {}, { Accept: Mime::JSON }
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    product = json(response.body)
    assert_equal 'Green', product[:data][:attributes][:color]
  end

  test "post request to '/products' creates a new product" do
    post '/products',
         { name: 'Diamond',
           price: 300.00,
           description: 'A real nice rock'
         }.to_json,
         { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    product = json(response.body)
    assert_equal 'Diamond', product[:data][:attributes][:name]
  end
end
