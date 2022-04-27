defmodule Paystack.Invoice.Base do
  @callback create(map) :: Paystack.Api.t()
  @callback list() :: Paystack.Api.t()
  @callback list(map | list) :: Paystack.Api.t()
  @callback view(String.t()) :: Paystack.Api.t()
  @callback verify(String.t()) :: Paystack.Api.t()
  @callback send_notification(String.t()) :: Paystack.Api.t()
  @callback total() :: Paystack.Api.t()
  @callback finalize(String.t()) :: Paystack.Api.t()
  @callback update(String.t(), map) :: Paystack.Api.t()
  @callback archive(String.t()) :: Paystack.Api.t()
end

defmodule Paystack.Invoice do
  import Paystack.Helpers, only: [paystack: 0]
  @behaviour __MODULE__.Base

  @moduledoc """
  The Invoices API allows you issue out and manage payment requests

  https://paystack.com/docs/api/#invoice
  """

  @doc """
  Create an invoice for payment on your integration
  """
  @impl true
  def create(params), do: paystack().post("/paymentrequest", params)

  @doc """
  List the invoice available on your integration.
  """
  @impl true
  def list(), do: paystack().get("/paymentrequest")

  @impl true
  def list(query_params),
    do: paystack().get("/paymentrequest?" <> URI.encode_query(query_params))

  @doc """
  Get details of an invoice on your integration.
  """
  @impl true
  def view(id_or_code), do: paystack().get("/paymentrequest/#{id_or_code}")

  @doc """
  Verify details of an invoice on your integration.
  """
  @impl true
  def verify(invoice_code), do: paystack().get("/paymentrequest/verify/#{invoice_code}")

  @doc """
  Send notification of an invoice to your customers
  """
  @impl true
  def send_notification(invoice_code),
    do: paystack().post("/paymentrequest/notify/#{invoice_code}")

  @doc """
  Get invoice metrics for dashboard
  """
  @impl true
  def total(), do: paystack().get("/paymentrequest/totals")

  @doc """
  Finalize a Draft Invoice
  """
  @impl true
  def finalize(invoice_code),
    do: paystack().post("/paymentrequest/finalize/#{invoice_code}")

  @doc """
  Update an invoice details on your integration
  """
  @impl true
  def update(id_or_code, params), do: paystack().put("/paymentrequest/#{id_or_code}", params)

  @doc """
  Used to archive an invoice. Invoice will no longer be fetched on list or returned on verify.
  """
  @impl true
  def archive(id_or_code),
    do: paystack().post("/paymentrequest/archive/#{id_or_code}")
end
