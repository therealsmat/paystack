defmodule PaystackMiscellanousTest do
  use PaystackEndpointHelper
  alias Paystack.Miscellanous

  test "list_banks/1" do
    assert_get_request_called_with("/bank?country=nigeria")
    Miscellanous.list_banks(%{country: "nigeria"})
  end

  test "list_providers/1" do
    assert_get_request_called_with("/banks?pay_with_bank_transfer=true")
    Miscellanous.list_providers(%{pay_with_bank_transfer: true})
  end

  test "list_countries/0" do
    assert_get_request_called_with("/country")
    Miscellanous.list_countries()
  end

  test "list_states" do
    assert_get_request_called_with("/address_verification/states?country=NG")
    Miscellanous.list_states(%{country: "NG"})
  end
end
