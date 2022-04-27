defmodule PaystackPlanTest do
  use PaystackEndpointHelper
  alias Paystack.Plan

  test "create/1" do
    params = %{
      business_name: "Sunshine Studios",
      settlement_bank: "044",
      account_number: "0193274682",
      percentage_charge: 18.2
    }

    assert_post_request_called_with("/plan", params)
    Plan.create(params)
  end

  test "list" do
    assert_get_request_called_with("/plan")
    Plan.list()

    # With query params as map
    query = %{active: false, perPage: "100"}
    assert_get_request_called_with("/plan?active=false&perPage=100")
    Plan.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/plan?active=true&name=commission")
    Plan.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/plan/asdflkj")
    Plan.fetch("asdflkj")
  end

  test "update/1" do
    params = %{name: "Updated Name", active: true}
    assert_put_request_called_with("/plan/asdf", params)
    Plan.update("asdf", params)
  end
end
