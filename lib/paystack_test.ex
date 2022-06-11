defmodule Paystack.Fake do
  require Logger

  defmacro __using__(opts) do
    quote location: :keep do
      import Paystack.Fake

      caller = unquote(opts) |> Keyword.get(:for, __MODULE__)

      caller
      |> Module.get_attribute(:behaviour)
      |> Enum.each(fn behaviour ->
        behaviour.behaviour_info(:callbacks)
        |> Enum.map(&define_function/1)
        |> define_module(caller)
      end)

      def fake() do
        IO.inspect("Setting fake module for #{inspect(__MODULE__)}")
      end
    end
  end

  def define_module(contents, real_module) do
    functions =
      quote do
        unquote(contents)
      end

    Module.create(String.to_atom("#{real_module}Fake"), functions, __ENV__)
  end

  def define_function({fun, arity}) do
    args = get_args(arity)

    quote do
      def unquote(fun)(unquote_splicing(args)) do
        Logger.debug(
          "Called function #{inspect(unquote(fun))} with args #{inspect(unquote(args))}"
        )
      end
    end
  end

  defp get_args(arity) do
    0..arity
    |> Enum.to_list()
    |> tl()
    |> Enum.map(&Macro.var(:"arg#{&1}", Elixir))
  end
end
