defmodule Paystack do

  @moduledoc """
  Paystack

  A library for working with [Paystack](https://paystack.com/) in Elixir

  [![Hex.pm](https://img.shields.io/hexpm/v/paystack.svg?maxAge=2592000)](https://hex.pm/packages/paystack) [![Hex.pm](https://img.shields.io/hexpm/dt/paystack.svg?maxAge=2592000)](https://hex.pm/packages/paystack)

  ## Installation
  Add paystack to your dependencies list in `mix.exs`
    ```elixir
    {:paystack, "~> #{Mix.Project.config()[:version]}"}
    ```
  Then run `mix deps.get`

  ## Configuration
  Add the following configuration to your `runtime.exs` or `config.exs` file. The runtime file is preferred if your secret key is injected into your environment at runtime.
    ```elixir
    config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")
    ```
  Your environment variable does not have to be `PAYSTACK_SECRET_KEY`, as the package only depends on the config key.

  ## Response
  This package returns responses in the format of `{:ok, Paystack.Response{}} | {:error, any}`. This means a successful request would look like this;

      iex> Paystack.Transaction.initialize(%{ email: "customer@email.com", amount: "20000" })
      {:ok,
        %Paystack.Response{
        data: %{
          "access_code" => "0peioxfhpn",
          "authorization_url" => "https://checkout.paystack.com/0peioxfhpn",
          "reference" => "7PVGX8MEk85tgeEpVDtD"
        },
        message: "Authorization URL created",
        meta: nil,
        status_code: 200,
        success: true
      }}

  An unsuccessful response would look like this;

      iex> Paystack.Transaction.initialize(%{ email: "customer@email.com", amount: "20000" })
      {:ok,
        %Paystack.Response{
          data: nil,
          message: "Invalid key",
          meta: nil,
          status_code: 401,
          success: false
        }}

  while an unexpected response would look like this.

      iex> Paystack.Transaction.initialize(%{ email: "customer@email.com", amount: "20000" })
      {:error, :nxdomain}

  Happy coding!
  """
end
