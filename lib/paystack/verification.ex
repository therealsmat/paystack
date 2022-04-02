defmodule Paystack.Verification do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Verification API allows you perform KYC processes

  https://paystack.com/docs/api/#verification
  """

  @doc """
  Confirm an account belongs to the right customer
  """
  @spec resolve_account_number(map | list) :: Paystack.Api.t
  def resolve_account_number(query_params),
    do: paystack().get("/bank/resolve?" <> URI.encode_query(query_params))

  @doc """
  Confirm the authenticity of a customer's account number before sending money
  """
  @spec validate_account(map) :: Paystack.Api.t
  def validate_account(params),
    do: paystack().post("/bank/validate", params)

  @doc """
  Get more information about a customer's card
  """
  @spec resolve_card_bin(String.t) :: Paystack.Api.t
  def resolve_card_bin(bin),
    do: paystack().get("/decision/bin/#{bin}")
end
