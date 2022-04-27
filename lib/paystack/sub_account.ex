defmodule Paystack.SubAccount.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
end

defmodule Paystack.SubAccount do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Subaccounts API allows you create and manage subaccounts on your integration.
  Subaccounts can be used to split payment between two accounts (your main account and a sub account)

  https://paystack.com/docs/api/#subaccount
  """

  @doc """
  Create a subacount on your integration
  """
  @impl true
  def create(params), do: paystack().post("/subaccount", params)

  @doc """
  List subaccounts available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/subaccount")

  @impl true
  def list(query_params),
    do: paystack().get("/subaccount?" <> URI.encode_query(query_params))

  @doc """
  Get details of a subaccount on your integration.
  """
  @impl true
  def fetch(id_or_code), do: paystack().get("/subaccount/#{id_or_code}")

  @doc """
  Update a subaccount details on your integration
  """
  @impl true
  def update(id_or_code, params),
    do: paystack().put("/subaccount/#{id_or_code}", params)
end
