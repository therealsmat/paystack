defmodule Paystack.ControlPanel do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Control Panel API allows you manage some settings on your integration

  https://paystack.com/docs/api/#control-panel
  """

  @doc """
  Fetch the payment session timeout on your integration
  """
  @spec fetch_payment_session_timeout() :: Paystack.Api.t
  def fetch_payment_session_timeout(),
    do: paystack().get("/integration/payment_session_timeout")

  @doc """
  Update the payment session timeout on your integration
  """
  @spec update_payment_session_timeout(map) :: Paystack.Api.t
  def update_payment_session_timeout(params),
    do: paystack().put("/integration/payment_session_timeout", params)
end
