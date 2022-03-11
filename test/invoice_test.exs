defmodule PaystackInvoiceTest do
  use PaystackEndpointHelper
  alias Paystack.Invoice

  test "create/1" do
    params = %{ name: "Buttercup Brunch", description: "Gather your friends for the ritual that is brunch" }
    assert_post_request_called_with("/paymentrequest", params)
    Invoice.create(params)
  end

  test "list" do
    assert_get_request_called_with("/paymentrequest")
    Invoice.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/paymentrequest?active=false&perPage=100")
    Invoice.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/paymentrequest?active=true&name=commission")
    Invoice.list(query)
  end

  test "view/1" do
    assert_get_request_called_with("/paymentrequest/3136406")
    Invoice.view("3136406")
  end

  test "verify/1" do
    assert_get_request_called_with("/paymentrequest/verify/123456")
    Invoice.verify("123456")
  end

  test "send_notification/1" do
    assert_post_request_called_with("/paymentrequest/notify/123456")
    Invoice.send_notification("123456")
  end

  test "total/1" do
    assert_get_request_called_with("/paymentrequest/totals")
    Invoice.total()
  end

  test "finalize/1" do
    assert_post_request_called_with("/paymentrequest/finalize/123456")
    Invoice.finalize("123456")
  end

  test "update/2" do
    params = %{ description: "Product Six Description" }
    assert_put_request_called_with("/paymentrequest/123456", params)
    Invoice.update(123456, params)
  end

  test "archive/1" do
    assert_post_request_called_with("/paymentrequest/archive/123456")
    Invoice.archive("123456")
  end
end
