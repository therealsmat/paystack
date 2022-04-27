defmodule Paystack.Refund.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.Refund do
  import Paystack.Helpers, only: [paystack: 0]

  @behaviour __MODULE__.Base

  @moduledoc """
  The Refunds API allows you create and manage transaction refunds

  https://paystack.com/docs/api/#refund
  """

  @doc """
  Initiate a refund on your integration
  """
  @impl true
  def create(params), do: paystack().post("/refund", params)

  @doc """
  List refunds available on your integration.
  """
  @impl true
  def list(query_params),
    do: paystack().get("/refund?" <> URI.encode_query(query_params))

  @doc """
  Get details of a refund on your integration.
  """
  @impl true
  def fetch(reference), do: paystack().get("/refund/#{reference}")
end
