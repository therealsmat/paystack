defmodule Paystack.Helpers do
  @moduledoc false

  @spec paystack() :: Paystack.Api.Behaviour
  def paystack(), do: Application.get_env(:paystack, :paystack_api, Paystack.Api)

  @spec base_url :: String.t() | nil
  def base_url(), do: Application.get_env(:paystack, :base_url, "https://api.paystack.co")

  @spec http_client() :: String.t() | nil
  def http_client(), do: Application.get_env(:paystack, :http_client, HTTPoison)
end
