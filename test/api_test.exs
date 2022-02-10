defmodule PaystackHttpClientTest do
  use ExUnit.Case
  alias Paystack.Api, as: PaystackApi
  import Mox

  setup do
    verify_on_exit!()
  end

  describe "get/1" do
    test "makes request with the correct configuration" do
      Application.put_env(:paystack, :base_url, "http://example.com")
      Application.put_env(:paystack, :secret_key, "12345678")

      HTTPoisonMock
      |> expect(:get, fn url, headers ->
        assert url == "http://example.com/product"
        assert Enum.sort(headers) == Enum.sort([{:Accept, "Application/json"}, {:Authorization, "Bearer 12345678"}])
        success_response(200)
      end)

      assert {:ok, _} = PaystackApi.get("/product")
    end
  end

  defp success_response(status_code, data \\ "") do
    {:ok, %HTTPoison.Response{
      body: ~s'{"status": true, "data": #{inspect(data)}}',
      headers: [{"Connection", "keep-alive"}, {"Server", "Cowboy"},
      {"Date", "Sat, 06 Jun 2015 03:52:13 GMT"}, {"Content-Length", "495"},
      {"Content-Type", "application/json"}, {"Via", "1.1 vegur"}],
      status_code: status_code
    }}
  end

  # defp failed_response(reason) do
  #   {:error, %HTTPoison.Error{reason: reason}}
  # end
end
