# Paystack :dollar::dollar:

A library for working with [Paystack](https://paystack.com/) in Elixir with out of the box support for telemetry events.

[![Elixir CI](https://github.com/therealsmat/paystack/actions/workflows/elixir.yml/badge.svg?branch=master)](https://github.com/therealsmat/paystack/actions/workflows/elixir.yml) [![Coverage Status](https://coveralls.io/repos/github/therealsmat/paystack/badge.svg?branch=master)](https://coveralls.io/github/therealsmat/paystack?branch=master) [![Hex.pm](https://img.shields.io/hexpm/v/paystack.svg?maxAge=2592000)](https://hex.pm/packages/paystack)

Comprehensive documentation available on [HexDocs](https://hex.pm/packages/paystack)

### Requirements
This package requires Elixir `v1.12+`

### Installation
Add the following to your `mix.exs` file
```elixir
  {:paystack, "~> 0.6.0"}
```
Then run `mix deps.get` to pull in the package

### Configuration
Add the following to your `config.exs` or `runtime.exs` file
```elixir
config :paystack, secret_key: System.get_env("PAYSTACK_SECRET_KEY")
```
Your environment variable does not have to be `PAYSTACK_SECRET_KEY`, as the package only depends on the config key.

  ### Usage
  This package returns responses in the format of `{:ok, Paystack.Response{}} | {:error, any}`. This means a successful request would look like this;
  ```elixir
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
  ```

  An unsuccessful response would look like this;
  ```elixir
  iex> Paystack.Transaction.initialize(%{ email: "customer@email.com", amount: "20000" })
  
  {:ok,
    %Paystack.Response{
      data: nil,
      message: "Invalid key",
      meta: nil,
      status_code: 401,
      success: false
    }}
  ```

  while an unexpected response would look like this.
  ```elixir
  iex> Paystack.Transaction.initialize(%{ email: "customer@email.com", amount: "20000" })
  
  {:error, :nxdomain}
  ```

  ## Telemetry
  This library executes the following telemetry events:
  * `[:paystack, :request, :start]` - Executed before sending a request
  Measurements
    * `system_time` - The system time

  * `[:paystack, :request, :stop]` - Executed after sending the final response
  Measurements
    * `duration` - The system time in `:native` unit
  
    Metadata
    * `url` - The paystack url requested
    * `request_type` - The http request type (`:get`, `:post`, `:put` or `:delete`)
    * `status_code` - The http response status code e.g `201`, `400`, `401`, e.t.c.
    * `response_type` - The library's response type (`:ok` or `:error`)
  
  Happy coding!

### Testing
Run `mix test`

### License
MIT

### TODO
- [x] Transactions
- [x] Transaction Splits
- [x] Customers
- [x] Dedicated Virtual Accounts
- [x] Apple Pay
- [x] Sub Accounts
- [x] Plans
- [x] Subscriptions
- [x] Products
- [x] Payment Pages
- [x] Invoices
- [x] Settlements
- [x] Transfer Recipients
- [x] Transfers
- [x] Transfer Control
- [x] Bulk Charges
- [x] Control Panel
- [x] Charge
- [x] Disputes
- [x] Refunds
- [x] Verification
- [x] Miscellaneous
