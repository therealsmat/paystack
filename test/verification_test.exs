defmodule PaystackVerificationTest do
  use PaystackEndpointHelper
  alias Paystack.Verification

  test "resolve_account_number/1" do
    params = %{account_number: "0022728151"}
    assert_get_request_called_with("/bank/resolve?account_number=0022728151")
    Verification.resolve_account_number(params)
  end

  test "validate_account/1" do
    params = %{bank_code: "632005", country_code: "ZA"}
    assert_post_request_called_with("/bank/validate", params)
    Verification.validate_account(params)
  end

  test "resolve_card_bin/1" do
    assert_get_request_called_with("/decision/bin/539983")
    Verification.resolve_card_bin("539983")
  end
end
