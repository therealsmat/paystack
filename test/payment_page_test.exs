defmodule PaystackPaymentPageTest do
  use PaystackEndpointHelper
  alias Paystack.PaymentPage

  test "create/1" do
    params = %{ name: "Buttercup Brunch", description: "Gather your friends for the ritual that is brunch" }
    assert_post_request_called_with("/page", params)
    PaymentPage.create(params)
  end

  test "list" do
    assert_get_request_called_with("/page")
    PaymentPage.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/page?active=false&perPage=100")
    PaymentPage.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/page?active=true&name=commission")
    PaymentPage.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/page/1173")
    PaymentPage.fetch("1173")
  end

  test "update/2" do
    params = %{ description: "PaymentPage Six Description" }
    assert_put_request_called_with("/page/526", params)
    PaymentPage.update(526, params)
  end

  test "check_slug_availability/1" do
    assert_get_request_called_with("/page/check_slug_availability/5nApBwZkvY")
    PaymentPage.check_slug_availability("5nApBwZkvY")
  end

  test "add_product/2" do
    assert_post_request_called_with("/page/5nApBwZkvY/product", %{ product: [1234, 4567] })
    PaymentPage.add_product("5nApBwZkvY", [1234, 4567])
  end
end
