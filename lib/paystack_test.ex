defmodule Paystack.Fake do
  require Logger

  defmacro __using__(opts) do
    quote location: :keep do
      import Paystack.Fake,
        only: [
          define_function: 2,
          define_module: 2,
          fake_name: 1
        ]

      alias Paystack.Fake.Server

      @me __MODULE__
      @real unquote(opts) |> Keyword.get(:for, @me)

      @me
      |> Module.get_attribute(:behaviour)
      |> Enum.each(fn behaviour ->
        behaviour.behaviour_info(:callbacks)
        |> Enum.map(&define_function(__MODULE__, &1))
        |> define_module(@me)
      end)

      def fake() do
        Application.put_env(:paystack, @me, fake_name(@me))
        Server.start_link(module: @me)
      end

      def restore() do
        Application.delete_env(:paystack, @me)
      end

      defmacro assert_called(fun, times \\ 1, args) do
        quote do
          calls = Server.find_call(unquote(@me), unquote(fun))

          refute calls == nil,
                 ~s'Expected function "#{unquote(fun)}" to be called at least once, but it was called 0 times'

          call_len = length(calls)

          assert call_len == unquote(times),
                 ~s'Expected function "#{unquote(fun)}" to be called #{unquote(times)} times, but it was called #{call_len} times'
        end
      end

      def impl() do
        Application.get_env(:paystack, @me, @real)
      end
    end
  end

  def define_module(contents, real_module) do
    functions =
      quote do
        unquote(contents)
      end

    Module.create(fake_name(real_module), functions, __ENV__)
  end

  def define_function(module_name, {fun, arity}) do
    args = get_args(arity)

    quote do
      def unquote(fun)(unquote_splicing(args)) do
        Paystack.Fake.Server.record_call(
          unquote(module_name),
          unquote(fun),
          unquote(args)
        )
      end
    end
  end

  def fake_name(module_name) do
    String.to_atom("#{module_name}Fake")
  end

  defp get_args(arity) do
    0..arity
    |> Enum.to_list()
    |> tl()
    |> Enum.map(&Macro.var(:"arg#{&1}", Elixir))
  end
end

defmodule Paystack.Fake.Server do
  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, name: Keyword.fetch!(opts, :module))
  end

  def record_call(server, fun, args) do
    GenServer.cast(server, {fun, args})
  end

  def find_call(server, fun) do
    GenServer.call(server, fun)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({fun, args}, state) do
    state =
      if Map.has_key?(state, fun) do
        Map.update!(state, fun, &[args | &1])
      else
        Map.put(state, fun, [args])
      end

    {:noreply, state}
  end

  def handle_call(fun, _from, state) do
    {:reply, Map.get(state, fun), state}
  end
end
