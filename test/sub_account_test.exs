defmodule PaystackSubAccountTest do
  use PaystackEndpointHelper
  alias Paystack.SubAccount

  test "create/1" do
    params = %{ business_name: "Sunshine Studios", settlement_bank: "044", account_number: "0193274682", percentage_charge: 18.2 }
    assert_post_request_called_with("/subaccount", params)
    SubAccount.create(params)
  end

  test "list" do
    assert_get_request_called_with("/subaccount")
    SubAccount.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/subaccount?active=false&perPage=100")
    SubAccount.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/subaccount?active=true&name=commission")
    SubAccount.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/subaccount/asdflkj")
    SubAccount.fetch("asdflkj")
  end

  test "update/1" do
    params = %{ name: "Updated Name", active: true }
    assert_put_request_called_with("/subaccount/asdf", params)
    SubAccount.update("asdf", params)
  end
end
