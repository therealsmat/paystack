defmodule PaystackEndpointHelper do
  # use ExUnit.Case
  @callback assert_get_request_called_with(String.t) :: term
  @callback assert_post_request_called_with(String.t, any()) :: term

  defmacro __using__(_) do
    quote location: :keep do
      @behaviour unquote(__MODULE__)
      import Mox
      use ExUnit.Case

      setup do
        verify_on_exit!()
      end

      def assert_get_request_called_with(url) do
        PaystackApiMock |> expect(:get, fn route ->
          assert route == url
        end)
      end

      def assert_post_request_called_with(url, params) do
        PaystackApiMock |> expect(:post, fn route, data ->
          assert route == url
          assert data == params
        end)
      end

      def assert_put_request_called_with(url, params) do
        PaystackApiMock |> expect(:put, fn route, data ->
          assert route == url
          assert data == params
        end)
      end

      def assert_delete_request_called_with(url) do
        PaystackApiMock |> expect(:delete, fn route ->
          assert route == url
        end)
      end

      def assert_delete_request_called_with(url, params) do
        PaystackApiMock |> expect(:delete, fn route, data ->
          assert route == url
          assert data == params
        end)
      end

      defoverridable []
    end
  end
end
