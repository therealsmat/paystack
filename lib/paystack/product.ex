defmodule Paystack.Product.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
end

defmodule Paystack.Product do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Products API allows you create and manage inventories on your integration

  https://paystack.com/docs/api/#product
  """

  @doc """
  Create a product on your integration
  """
  @impl true
  def create(params), do: paystack().post("/product", params)

  @doc """
  List products available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/product")

  @impl true
  def list(query_params),
    do: paystack().get("/product?" <> URI.encode_query(query_params))

  @doc """
  Get details of a product on your integration.
  """
  @impl true
  def fetch(product_id), do: paystack().get("/product/#{product_id}")

  @doc """
  Update a product details on your integration
  """
  @impl true
  def update(product_id, params), do: paystack().put("/product/#{product_id}", params)
end
