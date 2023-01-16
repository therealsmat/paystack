defmodule Paystack.Transfer do
  use Paystack
  alias Paystack.Api

  @moduledoc """
  The Transfers API allows you automate sending money on your integration

  https://paystack.com/docs/api/#transfer
  """

  @doc """
  Status of transfer object returned will be pending if OTP is disabled. In the event that an OTP is required, status will read otp.
  """
  def initialize(params), do: Api.post("/transfer", params)

  @doc """
  Finalize an initiated transfer
  """
  def finalize(params), do: Api.post("/transfer/finalize_transfer", params)

  @doc """
  You need to disable the Transfers OTP requirement to use this endpoint.
  """
  def initialize_bulk(params), do: Api.post("/transfer/bulk", params)

  @doc """
  List the transfers made on your integration.
  """
  def list(), do: get("/transfer")

  def list(query_params),
    do: Api.get("/transfer?" <> URI.encode_query(query_params))

  @doc """
  Get details of a transfer on your integration.
  """
  def fetch(id_or_code), do: Api.get("/transfer/#{id_or_code}")

  @doc """
  Verify the status of a transfer on your integration.
  """
  def verify(reference), do: Api.get("/transfer/verify/#{reference}")
end
