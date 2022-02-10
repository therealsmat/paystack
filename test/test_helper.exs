ExUnit.start()

Mox.defmock(HTTPoisonMock, for: HTTPoison.Base)
Application.put_env(:paystack, :http_client, HTTPoisonMock)
