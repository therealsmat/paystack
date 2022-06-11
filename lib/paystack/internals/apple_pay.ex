defmodule Paystack.Internals.ApplePay do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour Paystack.ApplePay.Base

  @moduledoc """
  The Apple Pay API allows you register your application's top-level domain or subdomain
  """

  @doc """
  Register a top-level domain or subdomain for your Apple Pay integration.
  """
  @impl true
  def register_domain(domain_name),
    do: paystack().post("/apple-pay/domain", %{domainName: domain_name})

  @doc """
  Lists all registered domains on your integration. Returns an empty array if no domains have been added.
  """
  @impl true
  def list_domains(), do: paystack().get("/apple-pay/domain")

  @doc """
  Unregister a top-level domain or subdomain previously used for your Apple Pay integration.
  """
  @impl true
  def unregister_domain(domain_name),
    do: paystack().delete("/apple-pay/domain", %{domainName: domain_name})
end
