defmodule PaystackDedicatedAccountTest do
  use PaystackEndpointHelper
  alias Paystack.DedicatedAccount

  test "create/1" do
    params = %{ customer: 481193, preferred_bank: "wema-bank" }
    assert_post_request_called_with("/dedicated_account", params)
    DedicatedAccount.create(params)
  end

  test "list/1" do
    query = %{ active: true, currency: "NGN" }
    assert_get_request_called_with("/dedicated_account?active=true&currency=NGN")
    DedicatedAccount.list(query)

    query = [active: true, currency: "NGN"]
    assert_get_request_called_with("/dedicated_account?active=true&currency=NGN")
    DedicatedAccount.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/dedicated_account/asdflkj")
    DedicatedAccount.fetch("asdflkj")
  end

  test "deactivate_account/1" do
    assert_delete_request_called_with("/dedicated_account/asdf")
    DedicatedAccount.deactivate_account("asdf")
  end

  test "split_transaction/1" do
    params = %{ customer: 481193, preferred_bank: "wema-bank", split_code: "SPL_e7jnRLtzla" }
    assert_post_request_called_with("/dedicated_account/split", params)
    DedicatedAccount.split_transaction(params)
  end

  test "remove_split/1" do
    assert_delete_request_called_with("/dedicated_account/split", %{ account_number: "0033322211" })
    DedicatedAccount.remove_split("0033322211")
  end

  test "bank_providers/0" do
    assert_get_request_called_with("/dedicated_account/available_providers")
    DedicatedAccount.bank_providers()
  end
end
