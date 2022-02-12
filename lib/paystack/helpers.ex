defmodule Paystack.Helpers do
  @moduledoc false

  def paystack(), do: Application.get_env(:paystack, :paystack_api, Paystack.Api)
  def base_url(), do: Application.get_env(:paystack, :base_url, "https://api.paystack.co")
  def http_client(), do: Application.get_env(:paystack, :http_client, HTTPoison)
end
