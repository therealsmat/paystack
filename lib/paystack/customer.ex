defmodule Paystack.Customer.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(list | map) :: Paystack.Api.t()
  @callback fetch(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
  @callback validate(String.t(), map) :: Paystack.Api.t()
  @callback blacklist(String.t()) :: Paystack.Api.t()
  @callback unblacklist(String.t()) :: Paystack.Api.t()
  @callback whitelist(String.t()) :: Paystack.Api.t()
  @callback unwhitelist(String.t()) :: Paystack.Api.t()
  @callback deactivate_authorization(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.Customer do
  @moduledoc """
  The Customers API allows you create and manage customers on your integration.

  https://paystack.com/docs/api/#customer
  """

  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @doc """
  Create a customer on your integration
  """
  @impl true
  def create(params), do: paystack().post("/customer", params)

  @doc """
  List customers available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/customer")

  @doc """
  List customers available on your integration with supported paystack query params.
  """
  @impl true
  def list(query), do: paystack().get("/customer?" <> URI.encode_query(query))

  @doc """
  Get details of a customer on your integration.
  """
  @impl true
  def fetch(email_or_customer_code), do: paystack().get("/customer/#{email_or_customer_code}")

  @doc """
  Update a customer's details on your integration
  """
  @impl true
  def update(customer_code, params), do: paystack().put("/customer/#{customer_code}", params)

  @doc """
  Validate a customer's identity
  """
  @impl true
  def validate(customer_code, params),
    do: paystack().post("/customer/#{customer_code}/identification", params)

  @doc """
  Blacklist a customer on your integration.
  """
  @impl true
  def blacklist(email_or_customer_code), do: set_risk_action(email_or_customer_code, "deny")

  @doc """
  Remove a customer from blacklist on your integration. This effectively sets the risk action to `default`.
  """
  @impl true
  def unblacklist(email_or_customer_code), do: set_risk_action(email_or_customer_code, "default")

  @doc """
  Whitelist a customer on your integration.
  """
  @impl true
  def whitelist(email_or_customer_code), do: set_risk_action(email_or_customer_code, "allow")

  @doc """
  Remove a customer from whitelist on your integration. This effectively sets the risk action to `default`.
  """
  @impl true
  def unwhitelist(email_or_customer_code), do: unblacklist(email_or_customer_code)

  @doc """
  Deactivate an authorization when the card needs to be forgotten.
  """
  @impl true
  def deactivate_authorization(authorization_code),
    do:
      paystack().post("/customer/deactivate_authorization", %{
        authorization_code: authorization_code
      })

  @spec set_risk_action(String.t(), String.t()) :: Paystack.Api.t()
  defp set_risk_action(email_or_customer_code, risk_action) do
    paystack().post("/customer/set_risk_action", %{
      customer: email_or_customer_code,
      risk_action: risk_action
    })
  end
end
