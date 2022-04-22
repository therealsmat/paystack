defmodule Paystack.Miscellanous.Base do
  @callback list_banks(map | list) :: Paystack.Api.t
  @callback list_providers(map | list) :: Paystack.Api.t
  @callback list_countries() :: Paystack.Api.t
  @callback list_states(map | list) :: Paystack.Api.t
end

defmodule Paystack.Miscellanous do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Miscellaneous API are supporting APIs that can be used to provide more details to other APIs
  """

  @doc """
  Get a list of all supported banks and their properties
  """
  @impl true
  def list_banks(query_params),
    do: paystack().get("/bank?" <> URI.encode_query(query_params))

  @doc """
  Gets a list of Countries that Paystack currently supports
  """
  @impl true
  def list_providers(query_params),
    do: paystack().get("/banks?" <> URI.encode_query(query_params))

  @doc """
  Gets a list of Countries that Paystack currently supports
  """
  @impl true
  def list_countries(), do: paystack().get("/country")

  @doc """
  Get a list of states for a country for address verification.
  """
  @impl true
  def list_states(query_params),
    do: paystack().get("/address_verification/states?" <> URI.encode_query(query_params))
end
