defmodule Paystack.Subscription.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback enable(map) :: Paystack.Api.t()
  @callback disable(map) :: Paystack.Api.t()
  @callback generate_update_link(String.t()) :: Paystack.Api.t()
  @callback send_update_link(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.Subscription do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Subscriptions API allows you create and manage recurring payment on your integration

  https://paystack.com/docs/api/#subscription
  """

  @doc """
  Create a subscription on your integration
  """
  @impl true
  def create(params), do: paystack().post("/subscription", params)

  @doc """
  List subscriptions available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/subscription")

  @impl true
  def list(query_params),
    do: paystack().get("/subscription?" <> URI.encode_query(query_params))

  @doc """
  Get details of a subscription on your integration.
  """
  @impl true
  def fetch(id_or_code), do: paystack().get("/subscription/#{id_or_code}")

  @doc """
  Enable a subscription on your integration
  """
  @impl true
  def enable(params), do: paystack().post("/subscription/enable", params)

  @doc """
  Disable a subscription on your integration
  """
  @impl true
  def disable(params), do: paystack().post("/subscription/disable", params)

  @doc """
  Generate a link for updating the card on a subscription
  """
  @impl true
  def generate_update_link(subscription_code),
    do: paystack().get("/subscription/#{subscription_code}/manage/link")

  @doc """
  Email a customer a link for updating the card on their subscription
  """
  @impl true
  def send_update_link(subscription_code),
    do: paystack().post("/subscription/#{subscription_code}/manage/email")
end
