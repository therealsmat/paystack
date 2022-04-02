defmodule Paystack.MixProject do
  use Mix.Project

  def project do
    [
      app: :paystack,
      version: "0.7.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Paystack",
      package: [
        files: ["lib", "mix.exs", "README.md"],
        maintainers: ["Tosin Soremekun"],
        licenses: ["MIT"],
        links: %{
          "Github" => "https://github.com/therealsmat/paystack",
        }
      ],
      description: "An elixir library for paystack",
      source_url: "https://github.com/therealsmat/paystack",
      docs: [
        main: "Paystack",
        groups_for_modules: groups_for_modules(),
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mox, "~> 1.0"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.3"},
      {:telemetry, "~> 1.0"},
      {:ex_doc, "~> 0.28.0", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14.4"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp groups_for_modules() do
    [
      "Response": [Paystack.Response],
      "Api": [Paystack.Api],
      "Core": [
        Paystack.Transaction,
        Paystack.Transfer,
        Paystack.Customer,
        Paystack.BulkCharge,
        Paystack.Charge
      ],
      "Other": [
        Paystack.SplitPayment,
        Paystack.DedicatedAccount,
        Paystack.ApplePay,
        Paystack.SubAccount,
        Paystack.Plan,
        Paystack.Subscription,
        Paystack.Product,
        Paystack.PaymentPage,
        Paystack.Invoice,
        Paystack.Settlement,
        Paystack.TransferRecipient,
        Paystack.TransferControl,
        Paystack.ControlPanel,
        Paystack.Dispute,
        Paystack.Refund,
        Paystack.Verification,
        Paystack.Miscellanous
      ]
    ]
  end
end
