defmodule PaystackDisputeTest do
  use PaystackEndpointHelper
  alias Paystack.Dispute

  test "list" do
    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/dispute?active=false&perPage=100")
    Dispute.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/dispute?active=true&name=commission")
    Dispute.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/dispute/2867")
    Dispute.fetch("2867")
  end

  test "list_transaction_disputes/1" do
    assert_get_request_called_with("/dispute/transaction/5991760")
    Dispute.list_transaction_disputes("5991760")
  end

  test "update/2" do
    params = %{refund_amount: 1002}
    assert_put_request_called_with("/dispute/2867", params)
    Dispute.update("2867", params)
  end

  test "add_evidence/2" do
    params = %{customer_email: "cus@gmail.com", customer_name: "Mensah King"}
    assert_post_request_called_with("/dispute/2867/evidence", params)
    Dispute.add_evidence("2867", params)
  end

  test "get_upload_url/2" do
    assert_get_request_called_with("/dispute/2867/upload_url?upload_filename=filename.ext")
    Dispute.get_upload_url("2867", "filename.ext")
  end

  test "resolve/2" do
    params = %{resolution: "merchant-accepted", message: "Merchant accepted"}
    assert_put_request_called_with("/dispute/2867/resolve", params)
    Dispute.resolve("2867", params)
  end

  test "export/1" do
    params = %{from: "2016-09-21", to: "2016-09-21"}
    assert_get_request_called_with("/dispute/export?from=2016-09-21&to=2016-09-21")
    Dispute.export(params)
  end
end
