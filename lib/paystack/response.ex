defmodule Paystack.Response do
  @type t :: %__MODULE__{
          success: boolean,
          message: String.t(),
          data: list,
          meta: list,
          status_code: integer
        }

  defstruct success: nil,
            message: "",
            data: [],
            meta: nil,
            status_code: nil
end
