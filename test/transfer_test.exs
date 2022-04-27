defmodule PaystackTransferTest do
  use PaystackEndpointHelper
  alias Paystack.Transfer

  test "initialize/1" do
    params = %{source: "balance", reason: "Calm down", amount: "3794800"}
    assert_post_request_called_with("/transfer", params)
    Transfer.initialize(params)
  end

  test "finalize/1" do
    params = %{transfer_code: "TRF_vsyqdmlzble3uii"}
    assert_post_request_called_with("/transfer/finalize_transfer", params)
    Transfer.finalize(params)
  end

  test "initialize_bulk/1" do
    params = %{transfer_code: "TRF_vsyqdmlzble3uii"}
    assert_post_request_called_with("/transfer/bulk", params)
    Transfer.initialize_bulk(params)
  end

  test "list" do
    assert_get_request_called_with("/transfer")
    Transfer.list()

    # With query params as map
    query = %{active: false, perPage: "100"}
    assert_get_request_called_with("/transfer?active=false&perPage=100")
    Transfer.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/transfer?active=true&name=commission")
    Transfer.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/transfer/1173")
    Transfer.fetch("1173")
  end

  test "verify/1" do
    assert_get_request_called_with("/transfer/verify/1173")
    Transfer.verify("1173")
  end
end
