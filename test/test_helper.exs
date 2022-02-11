Mox.defmock(HTTPoisonMock, for: HTTPoison.Base)
Mox.defmock(PaystackApiMock, for: Paystack.Api.Behaviour)

Application.put_env(:paystack, :http_client, HTTPoisonMock)
Application.put_env(:paystack, :paystack_api, PaystackApiMock)

ExUnit.start()
