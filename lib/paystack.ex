defmodule Paystack do
  @moduledoc false

  def paystack(), do: Application.get_env(:paystack, :paystack_api)
end
