defmodule Paystack.ControlPanel.Base do
  @callback fetch_payment_session_timeout() :: Paystack.Api.t()
  @callback update_payment_session_timeout(map) :: Paystack.Api.t()
end

defmodule Paystack.ControlPanel do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Control Panel API allows you manage some settings on your integration

  https://paystack.com/docs/api/#control-panel
  """

  @doc """
  Fetch the payment session timeout on your integration
  """
  @impl true
  def fetch_payment_session_timeout(),
    do: paystack().get("/integration/payment_session_timeout")

  @doc """
  Update the payment session timeout on your integration
  """
  @impl true
  def update_payment_session_timeout(params),
    do: paystack().put("/integration/payment_session_timeout", params)
end
