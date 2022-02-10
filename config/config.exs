import Config

config :paystack,
  base_url: "https://api.paystack.co",
  http_client: HTTPoison,
  secret_key: System.get_env("PAYSTACK_SECRET_KEY")
