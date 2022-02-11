defmodule PaystackHttpClientTest do
  use ExUnit.Case
  alias Paystack.Api, as: PaystackApi
  alias Paystack.Response
  import Mox

  @http HTTPoisonMock

  setup do
    verify_on_exit!()
  end

  describe "get/1" do
    test "makes request with the correct configuration" do
      Application.put_env(:paystack, :base_url, "http://example.com")
      Application.put_env(:paystack, :secret_key, "12345678")

      @http |> expect(:get, fn url, headers ->
        assert url == "http://example.com/product"
        assert Enum.sort(headers) == Enum.sort([{:Accept, "Application/json"}, {:Authorization, "Bearer 12345678"}])
        success_response(200)
      end)

      assert {:ok, _} = PaystackApi.get("/product")
    end

    test "responds with correct paystack data" do
      @http |> expect(:get, fn _, _ ->
        success_response(201, ~s<{"status": true, "message": "Authorization URL created", "data": {"authorization_url": "https://checkout.paystack.com/0peioxfhpn", "access_code": "0peioxfhpn"}}>)
      end)

      {:ok, %Response{} = response} = PaystackApi.get("/product")
      assert response.success == true
      assert response.message == "Authorization URL created"
      assert response.status_code == 201
      assert response.data == %{"authorization_url" => "https://checkout.paystack.com/0peioxfhpn", "access_code" => "0peioxfhpn"}
    end

    test "responds gracefully when there is an unknown error" do
      @http |> expect(:get, fn _, _ ->
        failed_response("Destination unreachable")
      end)

      assert {:error, response} = PaystackApi.get("/products")
      assert response == "Destination unreachable"
    end
  end

  describe "post/2" do
    test "makes request with the correct configuration" do
      Application.put_env(:paystack, :base_url, "http://example.com")
      Application.put_env(:paystack, :secret_key, "12345678")

      @http |> expect(:post, fn url, body, headers ->
        assert url == "http://example.com/charge"
        assert body == %{currency: "NGN", amount: "800", name: "Amala skye"}
        assert Enum.sort(headers) == Enum.sort([{:Accept, "Application/json"}, {:Authorization, "Bearer 12345678"}])
        success_response(200)
      end)

      assert {:ok, _} = PaystackApi.post("/charge", %{
        name: "Amala skye",
        amount: "800",
        currency: "NGN"
      })
    end

    test "responds with correct paystack data" do
      @http |> expect(:post, fn _, _, _ ->
        success_response(200, ~s<{"status": true, "message": "Charge created"}>)
      end)

    {:ok, %Response{} = response} = PaystackApi.post("/charge", %{name: "Amala skye"})

    assert response.success == true
    assert response.message == "Charge created"
    assert response.status_code == 200
    assert response.data == nil
    end

    test "responds gracefully when there is an unknown error" do
      @http |> expect(:post, fn _, _, _ -> failed_response("Destination unreachable") end)

      assert {:error, response} = PaystackApi.post("/charge")
      assert response == "Destination unreachable"
    end
  end

  describe "put/2" do
    test "makes request with the correct configuration" do
      Application.put_env(:paystack, :base_url, "http://example.com")
      Application.put_env(:paystack, :secret_key, "12345678")

      @http |> expect(:put, fn url, body, headers ->
        assert url == "http://example.com/charge/1"
        assert body == %{name: "Amala skye"}
        assert Enum.sort(headers) == Enum.sort([{:Accept, "Application/json"}, {:Authorization, "Bearer 12345678"}])
        success_response(200)
      end)

      assert {:ok, _} = PaystackApi.put("/charge/1", %{ name: "Amala skye" })
    end

    test "responds with correct paystack data" do
      @http |> expect(:put, fn _, _, _ ->
        success_response(200, ~s<{"status": true, "message": "Charge created"}>)
      end)

    {:ok, %Response{} = response} = PaystackApi.put("/charge", %{name: "Amala skye"})

    assert response.success == true
    assert response.message == "Charge created"
    assert response.status_code == 200
    assert response.data == nil
    end

    test "responds gracefully when there is an unknown error" do
      @http |> expect(:put, fn _, _, _ -> failed_response("Destination unreachable") end)

      assert {:error, response} = PaystackApi.put("/charge")
      assert response == "Destination unreachable"
    end
  end

  defp success_response(status_code, data \\ nil) do
    {:ok, %HTTPoison.Response{
      body: data || ~s<{"status": true, "message": "OK!"}>,
      headers: [{"Connection", "keep-alive"}, {"Server", "Cowboy"},
      {"Date", "Sat, 06 Jun 2015 03:52:13 GMT"}, {"Content-Length", "495"},
      {"Content-Type", "application/json"}, {"Via", "1.1 vegur"}],
      status_code: status_code
    }}
  end

  defp failed_response(reason) do
    {:error, %HTTPoison.Error{reason: reason}}
  end
end
