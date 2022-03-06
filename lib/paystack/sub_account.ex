defmodule Paystack.SubAccount do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Subaccounts API allows you create and manage subaccounts on your integration.
  Subaccounts can be used to split payment between two accounts (your main account and a sub account)
  """

  @doc """
  Create a subacount on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/subaccount", params)

  @doc """
  List subaccounts available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/subaccount")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/subaccount?" <> URI.encode_query(query_params))

  @doc """
  Get details of a subaccount on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(id_or_code), do: paystack().get("/subaccount/#{id_or_code}")

  @doc """
  Update a subaccount details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(id_or_code, params),
    do: paystack().put("/subaccount/#{id_or_code}", params)
end
