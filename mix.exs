defmodule Paystack.MixProject do
  use Mix.Project

  def project do
    [
      app: :paystack,
      version: "0.5.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Paystack",
      docs: [
        main: "Paystack",
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
      {:ex_doc, "~> 0.28.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
