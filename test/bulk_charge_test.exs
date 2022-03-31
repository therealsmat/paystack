defmodule PaystackBulkChargeTest do
  use PaystackEndpointHelper
  alias Paystack.BulkCharge

  test "initiate/1" do
    params = [
      %{authorization: "AUTH_n95vpedf", amount: "2500"},
      %{authorization: "AUTH_ljdt4e4j", amount: "1500"}
    ]
    assert_post_request_called_with("/bulkcharge", params)
    BulkCharge.initiate(params)
  end

  test "list_batches" do
    assert_get_request_called_with("/bulkcharge")
    BulkCharge.list_batches()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/bulkcharge?active=false&perPage=100")
    BulkCharge.list_batches(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/bulkcharge?active=true&name=commission")
    BulkCharge.list_batches(query)
  end

  test "fetch_batch/1" do
    assert_get_request_called_with("/bulkcharge/BCH_180tl7oq7cayggh")
    BulkCharge.fetch_batch("BCH_180tl7oq7cayggh")
  end

  test "fetch_batch_charges/1" do
    assert_get_request_called_with("/bulkcharge/BCH_180tl7oq7cayggh/charges")
    BulkCharge.fetch_batch_charges("BCH_180tl7oq7cayggh")
  end

  test "pause_batch/1" do
    assert_get_request_called_with("/bulkcharge/pause/BCH_180tl7oq7cayggh")
    BulkCharge.pause_batch("BCH_180tl7oq7cayggh")
  end

  test "resume_batch/1" do
    assert_get_request_called_with("/bulkcharge/resume/BCH_180tl7oq7cayggh")
    BulkCharge.resume_batch("BCH_180tl7oq7cayggh")
  end
end
