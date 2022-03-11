defmodule Paystack.PaymentPage do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Payment Pages API provides a quick and secure way to collect payment for products.

  https://paystack.com/docs/api/#page
  """

  @doc """
  Create a payment page on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/page", params)

  @doc """
  List payment pages available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/page")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/page?" <> URI.encode_query(query_params))

  @doc """
  Get details of a payment page on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(id_or_slug), do: paystack().get("/page/#{id_or_slug}")

  @doc """
  Update a payment page details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(id_or_slug, params), do: paystack().put("/page/#{id_or_slug}", params)

  @doc """
  Check the availability of a slug for a payment page.
  """
  @spec check_slug_availability(String.t) :: Paystack.Api.t
  def check_slug_availability(slug),
    do: paystack().get("/page/check_slug_availability/#{slug}")

  @doc """
  Add products to a payment page
  """
  @spec add_product(String.t, [integer]) :: Paystack.Api.t
  def add_product(page_id, product_ids),
    do: paystack().post("/page/#{page_id}/product", %{ product: product_ids })
end
