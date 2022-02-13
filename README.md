# Paystack :dollar::dollar:

A library for working with [Paystack](https://paystack.com/) in Elixir with out of the box support for telemetry events.

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

### Testing
Run `mix test`

### License
MIT

### TODO
- [x] Transactions
- [x] Transaction Splits
- [x] Customers
- [ ] Dedicated Virtual Accounts
- [ ] Apple Pay
- [ ] Sub Accounts
- [ ] Plans
- [ ] Subscriptions
- [ ] Products
- [ ] Payment Pages
- [ ] Invoices
- [ ] Settlements
- [ ] Transfer Recipients
- [ ] Transfers
- [ ] Transfer Control
- [ ] Bulk Charges
- [ ] Control Panel
- [ ] Charge
- [ ] Disputes
- [ ] Refunds
- [ ] Verification
- [ ] Miscellaneous
