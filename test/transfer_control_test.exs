defmodule PaystackTransferControlTest do
  use PaystackEndpointHelper
  alias Paystack.TransferControl

  test "check_balance/1" do
    assert_get_request_called_with("/balance")
    TransferControl.check_balance()
  end

  test "fetch_balance_ledger" do
    assert_get_request_called_with("/balance/ledger")
    TransferControl.fetch_balance_ledger()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/balance/ledger?active=false&perPage=100")
    TransferControl.fetch_balance_ledger(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/balance/ledger?active=true&name=commission")
    TransferControl.fetch_balance_ledger(query)
  end

  test "resend_otp/1" do
    params = %{transfer_code: "TRF_vsyqdmlzble3uii", reason: "resend_otp" }
    assert_post_request_called_with("/transfer/resend_otp", params)
    TransferControl.resend_otp(params)
  end

  test "disable_otp/0" do
    assert_post_request_called_with("/transfer/disable_otp", %{})
    TransferControl.disable_otp()
  end

  test "finalize_disable_otp/1" do
    assert_post_request_called_with("/transfer/disable_otp_finalize", %{otp: "928783"})
    TransferControl.finalize_disable_otp("928783")
  end

  test "enable_otp/0" do
    assert_post_request_called_with("/transfer/enable_otp", %{})
    TransferControl.enable_otp()
  end
end
