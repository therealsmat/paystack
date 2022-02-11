import Config

config :paystack,
  base_url: "http://example.org",
  http_client: HTTPoisonMock,
  secret_key: "1234"
