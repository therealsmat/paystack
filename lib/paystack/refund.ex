defmodule Paystack.Refund do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Refunds API allows you create and manage transaction refunds

  https://paystack.com/docs/api/#refund
  """

  @doc """
  Initiate a refund on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/refund", params)

  @doc """
  List refunds available on your integration.
  """
  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/refund?" <> URI.encode_query(query_params))

  @doc """
  Get details of a refund on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(reference), do: paystack().get("/refund/#{reference}")
end
