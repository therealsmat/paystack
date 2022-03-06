defmodule Paystack.SplitPayment do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Transaction Splits API enables merchants split the settlement for a transaction across their payout account, and one or more Subaccounts.

  https://paystack.com/docs/api/#split
  """

  @doc """
  Create a split payment on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/split", params)

  @doc """
  List/search for the transaction splits available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/split")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/split?" <> URI.encode_query(query_params))

  @doc """
  Get details of a split on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(split_id), do: paystack().get("/split/" <> split_id)

  @doc """
  Update a transaction split details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(split_id, params), do: paystack().put("/split/" <> split_id, params)

  @doc """
  Add a Subaccount to a Transaction Split, or update the share of an existing Subaccount in a Transaction Split
  """
  @spec add_subaccount(String.t, map) :: Paystack.Api.t
  def add_subaccount(split_id, params),
    do: paystack().post("/split/#{split_id}/subaccount/add", params)

  @doc """
  Remove a subaccount from a transaction split
  """
  @spec remove_subaccount(String.t, String.t) :: Paystack.Api.t
  def remove_subaccount(split_id, sub_account_code),
    do: paystack().post("/split/#{split_id}/subaccount/remove", %{ subaccount: sub_account_code })
end
