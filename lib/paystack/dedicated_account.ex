defmodule Paystack.DedicatedAccount do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Dedicated Virtual Account API enables merchants to manage unique payment accounts of their customers.

  https://paystack.com/docs/api/#dedicated-virtual-account-create
  """

  @type paystack_response() :: {:ok, Paystack.Response.t()} | {:error, any}

  @doc """
  Create a dedicated virtual account and assign to a customer
  """
  @spec create(map) :: paystack_response
  def create(params), do: paystack().post("/dedicated_account", params)

  @doc """
  List dedicated virtual accounts available on your integration.
  """
  @spec list(map | list) :: paystack_response
  def list(query_params),
    do: paystack().get("/dedicated_account?" <> URI.encode_query(query_params))

  @doc """
  Get details of a dedicated virtual account on your integration.
  """
  @spec fetch(integer) :: paystack_response
  def fetch(account_id), do: paystack().get("/dedicated_account/#{account_id}")

  @doc """
  Deactivate a dedicated virtual account on your integration.
  """
  @spec deactivate_account(integer) :: paystack_response
  def deactivate_account(account_id),
    do: paystack().delete("/dedicated_account/#{account_id}")

  @doc """
  Split a dedicated virtual account transaction with one or more accounts
  """
  @spec split_transaction(map) :: paystack_response
  def split_transaction(params), do: paystack().post("/dedicated_account/split", params)

  @doc """
  If you've previously set up split payment for transactions on a dedicated virtual account, you can remove it with this endpoint
  """
  @spec remove_split(String.t) :: paystack_response
  def remove_split(account_number),
    do: paystack().delete("/dedicated_account/split", %{ account_number: account_number })

  @doc """
  Get available bank providers for a dedicated virtual account
  """
  @spec bank_providers :: paystack_response
  def bank_providers(), do: paystack().get("/dedicated_account/available_providers")
end
