defmodule PaystackSubscriptionTest do
  use PaystackEndpointHelper
  alias Paystack.Subscription

  test "create/1" do
    params = %{customer: "CUS_xnxdt6s1zg1f4nx", plan: "PLN_gx2wn530m0i3w3m"}
    assert_post_request_called_with("/subscription", params)
    Subscription.create(params)
  end

  test "list" do
    assert_get_request_called_with("/subscription")
    Subscription.list()

    # With query params as map
    query = %{active: false, perPage: "100"}
    assert_get_request_called_with("/subscription?active=false&perPage=100")
    Subscription.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/subscription?active=true&name=commission")
    Subscription.list(query)
  end

  test "fetch/1" do
    assert_get_request_called_with("/subscription/1173")
    Subscription.fetch("1173")
  end

  test "enable/1" do
    params = %{code: "SUB_vsyqdmlzble3uii", token: "d7gofp6yppn3qz7"}
    assert_post_request_called_with("/subscription/enable", params)
    Subscription.enable(params)
  end

  test "disable/1" do
    params = %{code: "SUB_vsyqdmlzble3uii", token: "d7gofp6yppn3qz7"}
    assert_post_request_called_with("/subscription/disable", params)
    Subscription.disable(params)
  end

  test "generate_update_link/1" do
    assert_get_request_called_with("/subscription/qlgwhpyq1ts9nsw/manage/link")
    Subscription.generate_update_link("qlgwhpyq1ts9nsw")
  end

  test "send_update_link/1" do
    assert_post_request_called_with("/subscription/qlgwhpyq1ts9nsw/manage/email")
    Subscription.send_update_link("qlgwhpyq1ts9nsw")
  end
end
