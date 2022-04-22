defmodule Paystack.Charge.Base do
  @callback create(map) :: Paystack.Api.t
  @callback submit_pin(map) :: Paystack.Api.t
  @callback submit_otp(map) :: Paystack.Api.t
  @callback submit_phone(map) :: Paystack.Api.t
  @callback submit_birthday(map) :: Paystack.Api.t
  @callback submit_address(map) :: Paystack.Api.t
  @callback check_pending(String.t) :: Paystack.Api.t
end

defmodule Paystack.Charge do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Charge API allows you to configure payment channel of your choice when initiating a payment.

  https://paystack.com/docs/api/#charge
  """

  @doc """
  Initiate a payment by integrating the payment channel of your choice.
  """
  @impl true
  def create(params), do: paystack().post("/charge", params)

  @doc """
  Submit PIN to continue a charge
  """
  @impl true
  def submit_pin(params),
    do: paystack().post("/charge/submit_pin", params)

  @doc """
  Submit OTP to complete a charge
  """
  @impl true
  def submit_otp(params),
    do: paystack().post("/charge/submit_otp", params)

  @doc """
  Submit Phone when requested
  """
  @impl true
  def submit_phone(params),
    do: paystack().post("/charge/submit_phone", params)

  @doc """
  Submit Birthday when requested
  """
  @impl true
  def submit_birthday(params),
    do: paystack().post("/charge/submit_birthday", params)

  @doc """
  Submit address to continue a charge
  """
  @impl true
  def submit_address(params),
    do: paystack().post("/charge/submit_address", params)

  @doc """
  When you get "pending" as a charge status or if there was an exception when calling any of the /charge endpoints,
  wait 10 seconds or more, then make a check to see if its status has changed.
  Don't call too early as you may get a lot more pending than you should.
  """
  @impl true
  def check_pending(charge_reference),
    do: paystack().get("/charge/#{charge_reference}")
end
