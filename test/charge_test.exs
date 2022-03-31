defmodule PaystackChargeTest do
  use PaystackEndpointHelper
  alias Paystack.Charge

  test "create/1" do
    params = %{email: "customer@email.com", amount: "10000"}
    assert_post_request_called_with("/charge", params)
    Charge.create(params)
  end

  test "submit_pin/1" do
    params = %{pin: "1234", reference: "5bwib5v6anhe9xa"}
    assert_post_request_called_with("/charge/submit_pin", params)
    Charge.submit_pin(params)
  end

  test "submit_otp/1" do
    params = %{otp: "123456", reference: "5bwib5v6anhe9xa"}
    assert_post_request_called_with("/charge/submit_otp", params)
    Charge.submit_otp(params)
  end

  test "submit_phone/1" do
    params = %{phone: "08012345678", reference: "5bwib5v6anhe9xa"}
    assert_post_request_called_with("/charge/submit_phone", params)
    Charge.submit_phone(params)
  end

  test "submit_birthday/1" do
    params = %{birthday: "1961-09-21", reference: "5bwib5v6anhe9xa"}
    assert_post_request_called_with("/charge/submit_birthday", params)
    Charge.submit_birthday(params)
  end

  test "submit_address/1" do
    params = %{address: "140 N 2ND ST", city: "Stroudsburg", state: "PA", zip_code: "18360", reference: "5bwib5v6anhe9xa"}
    assert_post_request_called_with("/charge/submit_address", params)
    Charge.submit_address(params)
  end

  test "check_pending/1" do
    assert_get_request_called_with("/charge/5bwib5v6anhe9xa")
    Charge.check_pending("5bwib5v6anhe9xa")
  end
end
