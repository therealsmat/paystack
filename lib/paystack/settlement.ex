defmodule Paystack.Settlement do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Settlements API allows you gain insights into payouts made by Paystack to your bank account
  """

  @doc """
  Fetch settlements made to your settlement accounts.
  """
  @spec fetch() :: Paystack.Api.t
  def fetch(), do: paystack().get("/settlement")

  @spec fetch(map | list) :: Paystack.Api.t
  def fetch(query_params), do:
    paystack().get("/settlement?" <> URI.encode_query(query_params))

  @doc """
  Get the transactions that make up a particular settlement
  """
  @spec fetch_transactions(String.t) :: Paystack.Api.t
  def fetch_transactions(settlement_id),
    do: paystack().get("/settlement/#{settlement_id}/transactions")

  @spec fetch_transactions(String.t, map | list) :: Paystack.Api.t
  def fetch_transactions(settlement_id, query_params), do:
      paystack().get("/settlement/#{settlement_id}/transactions?" <> URI.encode_query(query_params))
end
