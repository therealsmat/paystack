defmodule Paystack.Transfer.Base do
  @callback initialize(map) :: Paystack.Api.t()
  @callback finalize(map) :: Paystack.Api.t()
  @callback initialize_bulk(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback verify(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.Transfer do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Transfers API allows you automate sending money on your integration

  https://paystack.com/docs/api/#transfer
  """

  @doc """
  Status of transfer object returned will be pending if OTP is disabled. In the event that an OTP is required, status will read otp.
  """
  @impl true
  def initialize(params), do: paystack().post("/transfer", params)

  @doc """
  Finalize an initiated transfer
  """
  @impl true
  def finalize(params),
    do: paystack().post("/transfer/finalize_transfer", params)

  @doc """
  You need to disable the Transfers OTP requirement to use this endpoint.
  """
  @impl true
  def initialize_bulk(params),
    do: paystack().post("/transfer/bulk", params)

  @doc """
  List the transfers made on your integration.
  """
  @impl true
  def list(), do: paystack().get("/transfer")

  @impl true
  def list(query_params),
    do: paystack().get("/transfer?" <> URI.encode_query(query_params))

  @doc """
  Get details of a transfer on your integration.
  """
  @impl true
  def fetch(id_or_code), do: paystack().get("/transfer/#{id_or_code}")

  @doc """
  Verify the status of a transfer on your integration.
  """
  @impl true
  def verify(reference), do: paystack().get("/transfer/verify/#{reference}")
end
