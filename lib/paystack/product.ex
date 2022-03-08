defmodule Paystack.Product do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Products API allows you create and manage inventories on your integration

  https://paystack.com/docs/api/#product
  """

  @doc """
  Create a product on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/product", params)

  @doc """
  List products available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/product")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/product?" <> URI.encode_query(query_params))

  @doc """
  Get details of a product on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(product_id), do: paystack().get("/product/#{product_id}")

  @doc """
  Update a product details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(product_id, params), do: paystack().put("/product/#{product_id}", params)
end
