defmodule Paystack.Transaction do
  import Paystack

  @moduledoc """
  The Transactions API allows you create and manage payments on your integration
  """

  @type paystack_response() :: {:ok, Paystack.Response.t()} | {:error, any}

  @doc """
  Initialize a transaction from your backend
  """
  @spec initialize(map()) :: paystack_response()
  def initialize(params), do: paystack().post("/transaction/initialize", params)

  @doc """
  Confirm the status of a transaction
  """
  @spec verify(String.t) :: paystack_response()
  def verify(transaction_reference), do: paystack().get("/transaction/verify/#{transaction_reference}")

  @doc """
  List transactions carried out on your integration.
  """
  @spec list :: paystack_response()
  def list(), do: paystack().get("/transaction")

  @doc """
  Get details of a transaction carried out on your integration.
  """
  @spec fetch(String.t) :: paystack_response()
  def fetch(transaction_id), do: paystack().get("/transaction/#{transaction_id}")

  @doc """
  All authorizations marked as reusable can be charged with this endpoint whenever you need to receive payments.
  """
  @spec charge_authorization(String.t, map) :: paystack_response()
  def charge_authorization(authorization_code, params),
    do: paystack().post("/transaction/charge_authorization", Map.merge(params, %{authorization_code: authorization_code}))

  @doc """
  All Mastercard and Visa authorizations can be checked with this endpoint to know if they have funds for the payment you seek.
  Visit the paystack documentation for more info https://paystack.com/docs/api/#transaction-check-authorization
  """
  @spec check_authorization(String.t, map) :: paystack_response()
  def check_authorization(authorization_code, params),
    do: paystack().post("/transaction/check_authorization", Map.merge(params, %{authorization_code: authorization_code}))

  @doc """
  View the timeline of a transaction
  """
  @spec timeline(String.t) :: paystack_response()
  def timeline(transaction_id_or_reference),
    do: paystack().get("/transaction/timeline/#{transaction_id_or_reference}")

  @doc """
  Total amount received on your account
  """
  @spec totals :: paystack_response()
  def totals(), do: paystack().get("/transaction/totals")

  @doc """
  List transactions carried out on your integration.
  """
  @spec export :: paystack_response()
  def export(), do: paystack().get("/transaction/export")

  @doc """
  Retrieve part of a payment from a customer
  """
  @spec partial_debit(String.t, map) :: paystack_response()
  def partial_debit(authorization_code, params),
    do: paystack().post("/transaction/partial_debit", Map.merge(params, %{authorization_code: authorization_code}))
end
