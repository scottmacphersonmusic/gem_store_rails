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
         { product: { name: 'Diamond',
           price: 300.00,
           description: 'A real nice rock'
         } }.to_json,
         { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    product = json(response.body)
    assert_equal 'Diamond', product[:data][:attributes][:name]
    assert_equal product_url(product[:data][:id]), response.location
  end

  test "creating a product requires at least a name and price" do
    post '/products',
         { product: { title: nil,
           price: nil,
           description: 'You can only imagine!'
         } }.to_json,
         { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type

    errors = json(response.body)
    assert_equal "can't be blank", errors[:name][0]
    assert_equal "can't be blank", errors[:price][0]
  end

  test "patch request to product endpoint updates product" do
    ruby = products(:ruby)
    patch "/products/#{ruby.id}?product[price]=80.00", {},
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_json }

    assert_equal 200, response.status
    assert_equal 80.00, ruby.reload.price
  end

  test "patch request won't update with invalid data" do
    ruby = products(:ruby)
    patch "/products/#{ruby.id}?product[name]=", {},
          { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_json }

    assert_equal 422, response.status
    errors = json(response.body)
    assert_equal "can't be blank", errors[:name][0]
  end

  test "deletes existing product" do
    emerald = products(:emerald)
    delete "/products/#{emerald.id}"
    assert_equal 204, response.status
    assert_empty Product.where(id: emerald.id)
  end
end
