defmodule PaystackApplePayTest do
  use PaystackEndpointHelper
  alias Paystack.ApplePay

  test "register_domain/1" do
    assert_post_request_called_with("/apple-pay/domain", %{ domainName: "example.com" })
    ApplePay.register_domain("example.com")
  end

  test "list_domains/0" do
    assert_get_request_called_with("/apple-pay/domain")
    ApplePay.list_domains()
  end

  test "unregister_domain/1" do
    assert_delete_request_called_with("/apple-pay/domain", %{ domainName: "example.com" })
    ApplePay.unregister_domain("example.com")
  end
end
