defmodule Paystack.Api.Behaviour do
  @moduledoc false

  @type paystack_response() :: {:error, any} | {:ok, Paystack.Response.t}

  @callback get(String.t) :: paystack_response()
  @callback post(String.t) :: paystack_response()
  @callback post(String.t, map()) :: paystack_response()
  @callback put(String.t) :: paystack_response()
  @callback put(String.t, map()) :: paystack_response()
end

defmodule Paystack.Api do
  @moduledoc false

  @behaviour __MODULE__.Behaviour
  alias Paystack.Response

  @impl true
  def get(route) do
    paystack_endpoint(route)
    |> http_client().get(http_headers())
    |> handle_response()
  end

  @impl true
  def post(route, body \\ %{}) do
    body = Jason.encode!(body)

    paystack_endpoint(route)
    |> http_client().post(body, http_headers())
    |> handle_response()
  end

  @impl true
  def put(route, body \\ %{}) do
    body = Jason.encode!(body)

    paystack_endpoint(route)
    |> http_client().put(body, http_headers())
    |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    body = Jason.decode!(body)
    {:ok, %Response{
      data: Map.get(body, "data"),
      success: Map.get(body, "status"),
      message: Map.get(body, "message"),
      meta: Map.get(body, "meta"),
      status_code: status_code
    }}
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp paystack_endpoint(route) do
    Application.get_env(:paystack, :base_url) <> route
  end

  defp http_client() do
    Application.get_env(:paystack, :http_client)
  end

  defp http_headers() do
    [
      "Authorization": "Bearer #{Application.get_env(:paystack, :secret_key)}",
      "Accept": "Application/json"
    ]
  end
end
