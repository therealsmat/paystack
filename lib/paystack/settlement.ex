defmodule Paystack.Settlement.Base do
  @callback fetch() :: Paystack.Api.t()
  @callback fetch(map | list) :: Paystack.Api.t()
  @callback fetch_transactions(String.t()) :: Paystack.Api.t()
  @callback fetch_transactions(String.t(), map | list) :: Paystack.Api.t()
end

defmodule Paystack.Settlement do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Settlements API allows you gain insights into payouts made by Paystack to your bank account
  """

  @doc """
  Fetch settlements made to your settlement accounts.
  """
  @impl true
  def fetch(), do: paystack().get("/settlement")

  @impl true
  def fetch(query_params), do: paystack().get("/settlement?" <> URI.encode_query(query_params))

  @doc """
  Get the transactions that make up a particular settlement
  """
  @impl true
  def fetch_transactions(settlement_id),
    do: paystack().get("/settlement/#{settlement_id}/transactions")

  @impl true
  def fetch_transactions(settlement_id, query_params),
    do:
      paystack().get(
        "/settlement/#{settlement_id}/transactions?" <> URI.encode_query(query_params)
      )
end
