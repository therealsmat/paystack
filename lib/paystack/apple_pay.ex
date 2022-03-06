defmodule Paystack.ApplePay do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Apple Pay API allows you register your application's top-level domain or subdomain
  """

  @doc """
  Register a top-level domain or subdomain for your Apple Pay integration.
  """
  @spec register_domain(String.t) :: Paystack.Api.t
  def register_domain(domain_name),
    do: paystack().post("/apple-pay/domain", %{ domainName: domain_name })

  @doc """
  Lists all registered domains on your integration. Returns an empty array if no domains have been added.
  """
  @spec list_domains :: Paystack.Api.t
  def list_domains(), do: paystack().get("/apple-pay/domain")

  @doc """
  Unregister a top-level domain or subdomain previously used for your Apple Pay integration.
  """
  @spec unregister_domain(String.t) :: Paystack.Api.t
  def unregister_domain(domain_name),
    do: paystack().delete("/apple-pay/domain", %{ domainName: domain_name })
end
