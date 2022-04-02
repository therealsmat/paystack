defmodule Paystack.Miscellanous do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Miscellaneous API are supporting APIs that can be used to provide more details to other APIs
  """

  @doc """
  Get a list of all supported banks and their properties
  """
  @spec list_banks(map | list) :: Paystack.Api.t
  def list_banks(query_params),
    do: paystack().get("/bank?" <> URI.encode_query(query_params))

  @doc """
  Gets a list of Countries that Paystack currently supports
  """
  @spec list_providers(map | list) :: Paystack.Api.t
  def list_providers(query_params),
    do: paystack().get("/banks?" <> URI.encode_query(query_params))

  @doc """
  Gets a list of Countries that Paystack currently supports
  """
  @spec list_countries() :: Paystack.Api.t
  def list_countries(), do: paystack().get("/country")

  @doc """
  Get a list of states for a country for address verification.
  """
  @spec list_states(map | list) :: Paystack.Api.t
  def list_states(query_params),
    do: paystack().get("/address_verification/states?" <> URI.encode_query(query_params))
end
