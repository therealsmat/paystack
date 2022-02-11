defmodule Paystack.SplitPayment do
  import Paystack

  @moduledoc """
  The Transaction Splits API enables merchants split the settlement for a transaction across their payout account, and one or more Subaccounts.
  """

  @type paystack_response() :: {:ok, Paystack.Response.t()} | {:error, any}

  @doc """
  Create a split payment on your integration
  """
  @spec create(map) :: paystack_response
  def create(params), do: paystack().post("/split", params)

  @doc """
  List/search for the transaction splits available on your integration.
  """
  @spec list() :: paystack_response
  def list(), do: paystack().get("/split")

  @spec list(map | list) :: paystack_response
  def list(query_params),
    do: paystack().get("/split?" <> URI.encode_query(query_params))

  @doc """
  Get details of a split on your integration.
  """
  @spec fetch(String.t) :: paystack_response
  def fetch(split_id), do: paystack().get("/split/" <> split_id)

  @doc """
  Update a transaction split details on your integration
  """
  @spec update(String.t, map) :: paystack_response
  def update(split_id, params), do: paystack().put("/split/" <> split_id, params)

  @doc """
  Add a Subaccount to a Transaction Split, or update the share of an existing Subaccount in a Transaction Split
  """
  @spec add_subaccount(String.t, map) :: paystack_response
  def add_subaccount(split_id, params),
    do: paystack().post("/split/#{split_id}/subaccount/add", params)

  @doc """
  Remove a subaccount from a transaction split
  """
  @spec remove_subaccount(String.t, String.t) :: paystack_response
  def remove_subaccount(split_id, sub_account_code),
    do: paystack().post("/split/#{split_id}/subaccount/remove", %{ subaccount: sub_account_code })
end
