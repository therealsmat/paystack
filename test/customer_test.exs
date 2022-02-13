defmodule PaystackCustomerTest do
  use PaystackEndpointHelper
  alias Paystack.Customer

  test "create/1 - makes a post request to the correct paystack endpoint" do
    params = %{ email: "zero@sum.com", first_name: "Zero", last_name: "Sum", phone: "+2348123456789" }
    assert_post_request_called_with("/customer", params)
    Customer.create(params)
  end

  test "list - makes a get request to the correct paystack endpoint" do
    assert_get_request_called_with("/customer")
    Customer.list()

    # With query params as map
    query = %{ active: false, perPage: "100" }
    assert_get_request_called_with("/customer?active=false&perPage=100")
    Customer.list(query)

    # With query params as list
    query = [active: true, name: "commission"]
    assert_get_request_called_with("/customer?active=true&name=commission")
    Customer.list(query)
  end

  test "fetch/1 - makes a get request to the correct paystack endpoint" do
    assert_get_request_called_with("/customer/asdf")
    Customer.fetch("asdf")
  end

  test "update/2 - makes a put request to the correct paystack endpoint" do
    params = %{ first_name: "BoJack" }
    assert_put_request_called_with("/customer/1234", params)
    Customer.update("1234", params)
  end

  test "validate/2 - makes a post request to the correct paystack endpoint" do
    params = %{ country: "NG", first_name: "Asta", last_name: "Lavista" }
    assert_post_request_called_with("/customer/1234/identification", params)
    Customer.validate("1234", params)
  end

  test "blacklist/1 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/customer/set_risk_action", %{ customer: "1234", risk_action: "deny" })
    Customer.blacklist("1234")
  end

  test "unblacklist/1 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/customer/set_risk_action", %{ customer: "1234", risk_action: "default" })
    Customer.unblacklist("1234")
  end

  test "whitelist/1 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/customer/set_risk_action", %{ customer: "1234", risk_action: "allow" })
    Customer.whitelist("1234")
  end

  test "unwhitelist/1 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/customer/set_risk_action", %{ customer: "1234", risk_action: "default" })
    Customer.unwhitelist("1234")
  end

  test "deactivate_authorization/1 - makes a post request to the correct paystack endpoint" do
    assert_post_request_called_with("/customer/deactivate_authorization", %{ authorization_code: "AUTH_72btv547" })
    Customer.deactivate_authorization("AUTH_72btv547")
  end
end
