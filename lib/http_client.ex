defmodule Paystack.HTTPClient.Behaviour do
  @type http_response() :: {:ok, result :: Paystack.Response.t} | {:error, error :: any}

  @callback get(String.t) :: http_response()
  @callback post(String.t, map) :: http_response()
  @callback put(String.t, map) :: http_response()
end

defmodule Paystack.HTTPClient do
  @behaviour __MODULE__.Behaviour

  @type http_response() :: {:ok, result :: Paystack.Response.t} | {:error, error :: any}

  alias Paystack.Response

  @client Tesla.client([
    {Tesla.Middleware.BaseUrl, "https://api.paystack.co"},
    {Tesla.Middleware.BearerAuth, [token: Application.get_env(:paystack, :secret_key)]},
    Tesla.Middleware.JSON
  ])

  def get(route) do
    @client |> Tesla.get(route) |> handle_response()
  end

  def post(route, body) do
    @client |> Tesla.post(route, body) |> handle_response()
  end

  def put(route, body) do
    @client |> Tesla.put(route, body) |> handle_response()
  end

  defp handle_response({:ok, %{ body: body, status: status_code }}) do
    {:ok, %Response{
      data: Map.get(body, "data", []),
      success: Map.get(body, "status"),
      message: Map.get(body, "message"),
      meta: Map.get(body, "meta"),
      status_code: status_code
    }}
  end

  # An unknown error occurred
  defp handle_response({:error, error}), do: {:error, error}
end
