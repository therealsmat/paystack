defmodule Paystack.Api.Behaviour do
  @moduledoc false

  @type paystack_response() :: {:error, any} | {:ok, Paystack.Response.t}

  @callback get(String.t) :: paystack_response()
  @callback post(String.t) :: paystack_response()
  @callback post(String.t, map()) :: paystack_response()
  @callback put(String.t) :: paystack_response()
  @callback put(String.t, map()) :: paystack_response()
  @callback delete(String.t) :: paystack_response()
  @callback delete(String.t, map()) :: paystack_response()
end

defmodule Paystack.Api do
  @behaviour __MODULE__.Behaviour
  alias Paystack.Response
  import Paystack.Helpers, only: [base_url: 0, http_client: 0]

  @type t :: {:ok, Response.t()} | {:error, any}

  @impl true
  def get(route) do
    with_telemetry(
      route,
      :get,
      fn ->
        paystack_endpoint(route)
        |> http_client().get(http_headers())
        |> handle_response()
      end
    )
  end

  @impl true
  def post(route, body \\ %{}) do
    body = Jason.encode!(body)

    with_telemetry(
      route,
      :post,
      fn ->
        paystack_endpoint(route)
        |> http_client().post(body, http_headers())
        |> handle_response()
      end
    )
  end

  @impl true
  def put(route, body \\ %{}) do
    body = Jason.encode!(body)

    with_telemetry(
      route,
      :put,
      fn ->
        paystack_endpoint(route)
        |> http_client().put(body, http_headers())
        |> handle_response()
      end
    )
  end

  @impl true
  def delete(route, body \\ %{}) do
    body = Jason.encode!(body)

    with_telemetry(
      route,
      :delete,
      fn ->
        # We use the request for HTTPoison because the default
        # `:post` does not support passing body...
        http_client().request(
          :delete,
          paystack_endpoint(route),
          body,
          http_headers()
        )
        |> handle_response()
      end
    )
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: status_code}}) do
    body = Jason.decode!(body)
    {:ok, %Response{
      data: Map.get(body, "data"),
      success: success_response?(Map.get(body, "status")),
      message: Map.get(body, "message"),
      meta: Map.get(body, "meta"),
      status_code: status_code
    }}
  end

  defp handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end

  defp paystack_endpoint(route) do
    base_url() <> route
  end

  defp http_headers() do
    [
      "Authorization": "Bearer #{Application.get_env(:paystack, :secret_key)}",
      "Accept": "Application/json"
    ]
  end

  defp success_response?(status) do
    case status do
      true -> true
      "success" -> true
      _ -> false
    end
  end

  @spec with_telemetry(String.t, atom, function) :: t()
  defp with_telemetry(route, request_type, fun) do
    :telemetry.span(
      [:paystack, :request],
      %{},
      fn ->
        case fun.() do
          {response_type, %{status_code: status_code}} = response ->
            meta = %{ url: route, request_type: request_type, response_type: response_type, status_code: status_code }
            {response, meta}
          _ = response ->
            meta = %{ url: route, request_type: request_type, response_type: :error, status_code: nil }
            {response, meta}
        end
      end
    )
  end
end
