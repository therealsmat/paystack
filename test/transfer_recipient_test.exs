defmodule PaystackTransferRecipientTest do
  use PaystackEndpointHelper
  alias Paystack.TransferRecipient

  test "create/1" do
    params = %{ name: "Tolu Robert", account_number: "01000000010" }
    assert_post_request_called_with("/transferrecipient", params)
    TransferRecipient.create(params)
  end

  test "bulk_create/1" do
    params = %{ name: "Tolu Robert", account_number: "01000000010" }
    assert_post_request_called_with("/transferrecipient/bulk", params)
    TransferRecipient.bulk_create(params)
  end

  test "list" do
    assert_get_request_called_with("/transferrecipient")
    TransferRecipient.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/transferrecipient?active=false&perPage=100")
    TransferRecipient.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/transferrecipient?active=true&name=commission")
    TransferRecipient.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/transferrecipient/1173")
    TransferRecipient.fetch("1173")
  end

  test "update/2" do
    params = %{ description: "Product Six Description" }
    assert_put_request_called_with("/transferrecipient/526", params)
    TransferRecipient.update(526, params)
  end

  test "delete/1" do
    assert_delete_request_called_with("/transferrecipient/526")
    TransferRecipient.delete(526)
  end
end
