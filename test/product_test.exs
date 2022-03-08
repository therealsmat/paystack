defmodule PaystackProductTest do
  use PaystackEndpointHelper
  alias Paystack.Product

  test "create/1" do
    params = %{ name: "Puff Puff", description: "Crispy flour ball with fluffy interior" }
    assert_post_request_called_with("/product", params)
    Product.create(params)
  end

  test "list" do
    assert_get_request_called_with("/product")
    Product.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/product?active=false&perPage=100")
    Product.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/product?active=true&name=commission")
    Product.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/product/1173")
    Product.fetch("1173")
  end

  test "update/2" do
    params = %{ description: "Product Six Description" }
    assert_put_request_called_with("/product/526", params)
    Product.update(526, params)
  end
end
