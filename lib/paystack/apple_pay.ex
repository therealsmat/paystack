defmodule Paystack.ApplePay.Base do
  @callback register_domain(String.t()) :: Paystack.Api.t()
  @callback list_domains :: Paystack.Api.t()
  @callback unregister_domain(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.ApplePay do
  @behaviour __MODULE__.Base
  use Paystack.Fake, for: Paystack.Internals.ApplePay

  @impl true
  def register_domain(domain_name), do: impl().register_domain(domain_name)

  @impl true
  def list_domains(), do: impl().list_domains()

  @impl true
  def unregister_domain(domain_name), do: impl().unregister_domain(domain_name)
end
