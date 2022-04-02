defmodule PaystackRefundTest do
  use PaystackEndpointHelper
  alias Paystack.Refund

  test "create/1" do
    params = %{transaction: 1641}
    assert_post_request_called_with("/refund", params)
    Refund.create(params)
  end

  test "list" do
    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/refund?active=false&perPage=100")
    Refund.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/refund?active=true&name=commission")
    Refund.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/refund/100982")
    Refund.fetch("100982")
  end
end
