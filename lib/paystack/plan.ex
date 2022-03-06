defmodule Paystack.Plan do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Plans API allows you create and manage installment payment options on your integration

  https://paystack.com/docs/api/#plan
  """

  @doc """
  Create a plan on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/plan", params)

  @doc """
  List plans available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/plan")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/plan?" <> URI.encode_query(query_params))

  @doc """
  Get details of a plan on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(id_or_code), do: paystack().get("/plan/#{id_or_code}")

  @doc """
  Update a plan details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(id_or_code, params),
    do: paystack().put("/plan/#{id_or_code}", params)
end
