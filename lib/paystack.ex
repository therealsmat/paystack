defmodule Paystack do

  @moduledoc """
  Paystack

  A library for working with [Paystack](https://paystack.com/) in Elixir

  [![Hex.pm](https://img.shields.io/hexpm/v/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe) [![Hex.pm](https://img.shields.io/hexpm/dt/stripity_stripe.svg?maxAge=2592000)](https://hex.pm/packages/stripity_stripe)

  ## Installation
  Add paystack to your dependencies list in `mix.exs`
    ```elixir
    {:#{Mix.Project.config()[:app]}, "~> #{Mix.Project.config()[:version]}"}
    ```
  Then run `mix deps.get`

  ## Configuration
  Add the following configuration to your `runtime.exs` or `config.exs` file. The runtime file is preferred if your secret key is injected into your environment at runtime.
    ```elixir
    config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")
    ```
  Your environment variable does not have to be `PAYSTACK_SECRET_KEY`, as the package only depends on the config key.
  """
end
