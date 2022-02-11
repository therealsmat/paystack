defmodule PaystackTransactionTest do
  use PaystackEndpointHelper
  alias Paystack.Transaction

  test "initialize/1 - makes a post request to the correct paystack endpoint" do
    params = %{ email: "hello@example.com" }
    assert_post_request_called_with("/transaction/initialize", params)
    Transaction.initialize(params)
  end

  test "verify/1 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction/verify/12345678")
    Transaction.verify("12345678")
  end

  test "list/0 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction")
    Transaction.list()
  end

  test "fetch/1 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction/1234")
    Transaction.fetch("1234")
  end

  test "charge_authorization/2 - makes post request to the correct paystack endpoint" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/charge_authorization", params)
    Transaction.charge_authorization("AUTH_72btv547", params)
  end

  test "charge_authorization/2 - will overwrite any authorization_code property provided in params" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/charge_authorization", %{ params | authorization_code: "AUTH_9879w2btv547" })
    Transaction.charge_authorization("AUTH_9879w2btv547", params)
  end

  test "check_authorization/2 - makes post request to the correct paystack endpoint" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/check_authorization", params)
    Transaction.check_authorization("AUTH_72btv547", params)
  end

  test "check_authorization/2 - will overwrite any authorization_code property provided in params" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/check_authorization", %{ params | authorization_code: "AUTH_9879w2btv547" })
    Transaction.check_authorization("AUTH_9879w2btv547", params)
  end

  test "timeline/1 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction/timeline/asdflkjahssd")
    Transaction.timeline("asdflkjahssd")
  end

  test "totals/0 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction/totals")
    Transaction.totals()
  end

  test "export/0 - makes get request to the correct paystack endpoint" do
    assert_get_request_called_with("/transaction/export")
    Transaction.export()
  end

  test "partial_debit/2 - makes get request to the correct paystack endpoint" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/partial_debit", params)
    Transaction.partial_debit("AUTH_72btv547", params)
  end

  test "partial_debit/2 - will overwrite any authorization_code property provided in params" do
    params = %{ email: "me@tosinsoremekun.com", amount: 20000, authorization_code: "AUTH_72btv547" }
    assert_post_request_called_with("/transaction/partial_debit", %{ params | authorization_code: "AUTH_9879w2btv547"})
    Transaction.partial_debit("AUTH_9879w2btv547", params)
  end
end
