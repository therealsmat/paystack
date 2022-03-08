defmodule Paystack.Subscription do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Subscriptions API allows you create and manage recurring payment on your integration

  https://paystack.com/docs/api/#subscription
  """

  @doc """
  Create a subscription on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/subscription", params)

  @doc """
  List subscriptions available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/subscription")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/subscription?" <> URI.encode_query(query_params))

  @doc """
  Get details of a subscription on your integration.
  """
  @spec fetch(String.t) :: Paystack.Api.t
  def fetch(id_or_code), do: paystack().get("/subscription/#{id_or_code}")

  @doc """
  Enable a subscription on your integration
  """
  @spec enable(map) :: Paystack.Api.t
  def enable(params), do: paystack().post("/subscription/enable", params)

  @doc """
  Disable a subscription on your integration
  """
  @spec disable(map) :: Paystack.Api.t
  def disable(params), do: paystack().post("/subscription/disable", params)

  @doc """
  Generate a link for updating the card on a subscription
  """
  @spec generate_update_link(String.t) :: Paystack.Api.t
  def generate_update_link(subscription_code),
    do: paystack().get("/subscription/#{subscription_code}/manage/link")

  @doc """
  Email a customer a link for updating the card on their subscription
  """
  @spec send_update_link(String.t) :: Paystack.Api.t
  def send_update_link(subscription_code),
    do: paystack().post("/subscription/#{subscription_code}/manage/email")
end
