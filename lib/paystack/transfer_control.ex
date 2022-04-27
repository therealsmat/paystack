defmodule Paystack.TransferControl.Base do
  @callback check_balance() :: Paystack.Api.t()
  @callback fetch_balance_ledger() :: Paystack.Api.t()
  @callback fetch_balance_ledger(map | list) :: Paystack.Api.t()
  @callback resend_otp(map) :: Paystack.Api.t()
  @callback disable_otp() :: Paystack.Api.t()
  @callback finalize_disable_otp(String.t()) :: Paystack.Api.t()
  @callback enable_otp() :: Paystack.Api.t()
end

defmodule Paystack.TransferControl do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Transfers Control API allows you manage settings of your transfers

  https://paystack.com/docs/api/#transfer-control
  """

  @doc """
  Fetch the available balance on your integration
  """
  @impl true
  def check_balance(), do: paystack().get("/balance")

  @doc """
  Fetch all pay-ins and pay-outs that occured on your integration
  """
  @impl true
  def fetch_balance_ledger(), do: paystack().get("/balance/ledger")

  @impl true
  def fetch_balance_ledger(query_params),
    do: paystack().get("/balance/ledger?" <> URI.encode_query(query_params))

  @doc """
  Generates a new OTP and sends to customer in the event they are having trouble receiving one.
  """
  @impl true
  def resend_otp(params), do: paystack().post("/transfer/resend_otp", params)

  @doc """
  This is used in the event that you want to be able to complete transfers programmatically without use of OTPs.
  No arguments required. You will get an OTP to complete the request.
  """
  @impl true
  def disable_otp(), do: paystack().post("/transfer/disable_otp", %{})

  @doc """
  Finalize the request to disable OTP on your transfers.
  """
  @impl true
  def finalize_disable_otp(otp),
    do: paystack().post("/transfer/disable_otp_finalize", %{otp: otp})

  @doc """
  In the event that a customer wants to stop being able to complete transfers programmatically, this endpoint helps turn OTP requirement back on. No arguments required.
  """
  @impl true
  def enable_otp(), do: paystack().post("/transfer/enable_otp", %{})
end
