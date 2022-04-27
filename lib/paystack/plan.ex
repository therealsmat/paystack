defmodule Paystack.Plan.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
end

defmodule Paystack.Plan do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Plans API allows you create and manage installment payment options on your integration

  https://paystack.com/docs/api/#plan
  """

  @doc """
  Create a plan on your integration
  """
  @impl true
  def create(params), do: paystack().post("/plan", params)

  @doc """
  List plans available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/plan")

  @impl true
  def list(query_params),
    do: paystack().get("/plan?" <> URI.encode_query(query_params))

  @doc """
  Get details of a plan on your integration.
  """
  @impl true
  def fetch(id_or_code), do: paystack().get("/plan/#{id_or_code}")

  @doc """
  Update a plan details on your integration
  """
  @impl true
  def update(id_or_code, params),
    do: paystack().put("/plan/#{id_or_code}", params)
end
