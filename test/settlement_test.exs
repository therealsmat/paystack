defmodule PaystackSettlementTest do
  use PaystackEndpointHelper
  alias Paystack.Settlement

  test "fetch" do
    assert_get_request_called_with("/settlement")
    Settlement.fetch()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/settlement?active=false&perPage=100")
    Settlement.fetch(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/settlement?active=true&name=commission")
    Settlement.fetch(query)
  end

  test "fetch_transactions" do
    assert_get_request_called_with("/settlement/1234/transactions")
    Settlement.fetch_transactions("1234")

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/settlement/1234/transactions?active=false&perPage=100")
    Settlement.fetch_transactions("1234", query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/settlement/1234/transactions?active=true&name=commission")
    Settlement.fetch_transactions("1234", query)
  end
end
