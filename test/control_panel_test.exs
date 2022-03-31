defmodule PaystackControlPanelTest do
  use PaystackEndpointHelper
  alias Paystack.ControlPanel

  test "fetch_payment_session_timeout/0" do
    assert_get_request_called_with("/integration/payment_session_timeout")
    ControlPanel.fetch_payment_session_timeout()
  end

  test "update_payment_session_timeout" do
    assert_put_request_called_with("/integration/payment_session_timeout", %{timeout: 30})
    ControlPanel.update_payment_session_timeout(%{timeout: 30})
  end
end
