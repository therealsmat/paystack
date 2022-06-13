defmodule PaystackApplePayTest do
  use PaystackEndpointHelper
  alias Paystack.ApplePay
  require ApplePay

  setup do
    on_exit(&ApplePay.restore/0)
  end

  test "register_domain/1" do
    assert_post_request_called_with("/apple-pay/domain", %{domainName: "example.com"})
    ApplePay.register_domain("example.com")
  end

  test "list_domains/0" do
    assert_get_request_called_with("/apple-pay/domain")
    ApplePay.list_domains()
  end

  test "unregister_domain/1" do
    assert_delete_request_called_with("/apple-pay/domain", %{domainName: "example.com"})
    ApplePay.unregister_domain("example.com")
  end

  test "fake/0" do
    ApplePay.fake()
    ApplePay.unregister_domain("tosinsoremekun.com")
    ApplePay.assert_called(:unregister_domain, fn domain ->
      assert domain == "tosinsoremekun.com"
    end)
  end
end
