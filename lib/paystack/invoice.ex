defmodule Paystack.Invoice do
  import Paystack.Helpers, only: [paystack: 0]

  @moduledoc """
  The Invoices API allows you issue out and manage payment requests

  https://paystack.com/docs/api/#invoice
  """

  @doc """
  Create an invoice for payment on your integration
  """
  @spec create(map) :: Paystack.Api.t
  def create(params), do: paystack().post("/paymentrequest", params)

  @doc """
  List the invoice available on your integration.
  """
  @spec list() :: Paystack.Api.t
  def list(), do: paystack().get("/paymentrequest")

  @spec list(map | list) :: Paystack.Api.t
  def list(query_params),
    do: paystack().get("/paymentrequest?" <> URI.encode_query(query_params))

  @doc """
  Get details of an invoice on your integration.
  """
  @spec view(String.t) :: Paystack.Api.t
  def view(id_or_code), do: paystack().get("/paymentrequest/#{id_or_code}")

  @doc """
  Verify details of an invoice on your integration.
  """
  @spec verify(String.t) :: Paystack.Api.t
  def verify(invoice_code), do: paystack().get("/paymentrequest/verify/#{invoice_code}")

  @doc """
  Send notification of an invoice to your customers
  """
  @spec send_notification(String.t) :: Paystack.Api.t
  def send_notification(invoice_code),
    do: paystack().post("/paymentrequest/notify/#{invoice_code}")

  @doc """
  Get invoice metrics for dashboard
  """
  @spec total() :: Paystack.Api.t
  def total(), do: paystack().get("/paymentrequest/totals")

  @doc """
  Finalize a Draft Invoice
  """
  @spec finalize(String.t) :: Paystack.Api.t
  def finalize(invoice_code),
    do: paystack().post("/paymentrequest/finalize/#{invoice_code}")

  @doc """
  Update an invoice details on your integration
  """
  @spec update(String.t, map) :: Paystack.Api.t
  def update(id_or_code, params), do: paystack().put("/paymentrequest/#{id_or_code}", params)

  @doc """
  Used to archive an invoice. Invoice will no longer be fetched on list or returned on verify.
  """
  @spec archive(String.t) :: Paystack.Api.t
  def archive(id_or_code),
    do: paystack().post("/paymentrequest/archive/#{id_or_code}")
end
