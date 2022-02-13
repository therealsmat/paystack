import Config

config :paystack,
  secret_key: System.get_env("PAYSTACK_SECRET_KEY")
