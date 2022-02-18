defmodule PaystackSplitPaymentTest do
  use PaystackEndpointHelper
  alias Paystack.SplitPayment

  test "create/1 - makes a post request to the correct paystack endpoint" do
    params = %{ name: "Ezra Olubi", type: "percentage" }
    assert_post_request_called_with("/split", params)
    SplitPayment.create(params)
  end

  test "list - makes a get request to the correct paystack endpoint" do
    assert_get_request_called_with("/split")
    SplitPayment.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/split?active=false&perPage=100")
    SplitPayment.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/split?active=true&name=commission")
    SplitPayment.list(query)
  end

  test "fetch/1 - makes a get request to the correct paystack endpoint" do
    assert_get_request_called_with("/split/asdflkj")
    SplitPayment.fetch("asdflkj")
  end

  test "update/2 - makes a put request to the correct paystack endpoint" do
    params = %{ name: "Updated Name", active: true }
    assert_put_request_called_with("/split/asdf", params)
    SplitPayment.update("asdf", params)
  end

  test "add_subaccount/2 - makes a post request to the correct paystack endpoint" do
    params = %{subaccount: "ACCT_hdl8abxl8drhrl3", share: 40000}
    assert_post_request_called_with("/split/asdf/subaccount/add", params)
    SplitPayment.add_subaccount("asdf", params)
  end

  test "remove_subaccount/2 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/split/asdf/subaccount/remove", %{ subaccount: "ACCT_hdl8abxl8drhrl3" })
    SplitPayment.remove_subaccount("asdf", "ACCT_hdl8abxl8drhrl3")
  end
end
